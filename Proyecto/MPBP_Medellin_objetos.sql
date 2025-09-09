-- usamos la base de datos de MPBP_Medellin
USE MPBP_Medellin;

-- vista #1 de eventos x cliente
-- esta vista nos muestra de forma clara y ordenada todos los eventos contratados por el cliente
CREATE VIEW vista_eventos_por_cliente AS
SELECT 
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.tipo_evento,
  e.fecha_evento,
  e.lugar,
  e.cantidad_personas,
  e.nombre_evento,
  COALESCE(te.total_evento, 0) AS costo_total
FROM eventos e
JOIN clientes c ON c.id_cliente = e.id_cliente
LEFT JOIN (
  SELECT id_evento, SUM(subtotal) AS total_evento
  FROM eventos_servicios
  GROUP BY id_evento
) te ON te.id_evento = e.id_evento;

-- consulta para vista de eventos por cliente
SELECT * FROM vista_eventos_por_cliente;

-- vista #2 vista de los servicios mas contratados
SELECT
  s.tipo_servicio,
  s.id_servicio,
  s.nombre_servicio,
  COUNT(es.id_evento_servicio) AS veces_contratado,
  COALESCE(SUM(es.cantidad),0) AS cantidad_total
FROM servicios s
LEFT JOIN eventos_servicios es ON s.id_servicio = es.id_servicio
GROUP BY s.tipo_servicio, s.id_servicio, s.nombre_servicio
ORDER BY cantidad_total DESC;


DROP VIEW IF EXISTS vista_estado_pago_evento;

-- consulta de los servicios mas contratados
SELECT * FROM vista_servicios_mas_contratados;

-- vista #3 vista del total gastado por cliente en un evento
CREATE VIEW vista_total_gastado_por_cliente AS
SELECT 
  c.id_cliente,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  COUNT(DISTINCT e.id_evento) AS total_eventos,
  COALESCE(SUM(ev.total_evento), 0) AS total_gastado
FROM clientes c
LEFT JOIN eventos e ON e.id_cliente = c.id_cliente
LEFT JOIN (
  SELECT id_evento, SUM(subtotal) AS total_evento
  FROM eventos_servicios
  GROUP BY id_evento
) ev ON ev.id_evento = e.id_evento
GROUP BY c.id_cliente, cliente
ORDER BY total_gastado DESC;

-- consulta de vista de total gastado por cliente
SELECT * FROM vista_total_gastado_por_cliente;

-- Clientes que han gastado más de $50,000
SELECT * FROM vista_total_gastado_por_cliente
WHERE total_gastado > 50000;

-- vista #4 vista por el estado del pago del evento
CREATE VIEW vista_estado_pago_evento AS
SELECT
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.nombre_evento,
  COALESCE(te.total_evento, 0)  AS total_servicios,
  COALESCE(tp.total_pagado, 0)  AS total_pagado,
  CASE 
    WHEN COALESCE(tp.total_pagado,0) >= COALESCE(te.total_evento,0) THEN 'Pagado'
    ELSE 'Pendiente'
  END AS estado_pago
FROM eventos e
JOIN clientes c ON c.id_cliente = e.id_cliente
LEFT JOIN (
  SELECT id_evento, SUM(subtotal) AS total_evento
  FROM eventos_servicios
  GROUP BY id_evento
) te  ON te.id_evento = e.id_evento
LEFT JOIN (
  SELECT id_evento, SUM(monto) AS total_pagado
  FROM pagos
  WHERE pagado = TRUE   
  GROUP BY id_evento
) tp  ON tp.id_evento = e.id_evento;

-- consulta vista #4
SELECT * FROM vista_estado_pago_evento;

-- consulta de los eventos que estan pagados completamente
SELECT *
FROM vista_estado_pago_evento
WHERE estado_pago = 'Pagado';

-- vista #5 carga de trabajo por empleado
CREATE VIEW vista_carga_empleado AS
SELECT 
  emp.id_empleado,
  emp.nombre,
  emp.apellido,
  emp.puesto,
  COUNT(DISTINCT ee.id_evento)           AS eventos_asignados,
  COALESCE(SUM(ee.horas_estimadas), 0)   AS horas_asignadas
FROM empleados emp
LEFT JOIN eventos_empleados ee 
  ON ee.id_empleado = emp.id_empleado
GROUP BY 
  emp.id_empleado, emp.nombre, emp.apellido, emp.puesto
ORDER BY horas_asignadas DESC, eventos_asignados DESC, emp.apellido, emp.nombre;

-- consulta para vista #5
SELECT * FROM vista_carga_empleado;
-- consulta completa de los empleados destinados a un evento, su rol y sus horas destinadas
SELECT 
  e.id_evento, e.nombre_evento, e.fecha_evento,
  emp.id_empleado, emp.nombre, emp.apellido, 
  ee.rol_en_evento, ee.horas_estimadas
FROM eventos_empleados ee
JOIN eventos   e   ON e.id_evento = ee.id_evento
JOIN empleados emp ON emp.id_empleado = ee.id_empleado
ORDER BY emp.apellido, emp.nombre, e.fecha_evento;


-- funcion #1 para saber el total pagado por un evento por id
DELIMITER $$

CREATE FUNCTION fn_total_pagado_evento(p_evento INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT IFNULL(SUM(monto), 0)
  INTO total
  FROM pagos
  WHERE id_evento = p_evento
    AND pagado = TRUE;   -- solo pagos confirmados

  RETURN total;
END$$
DELIMITER ;

-- consulta para funcion de saber el total pagado por evento
SELECT fn_total_pagado_evento(1) AS total_pagado_evento_1;

-- consulta del nombre del evento y el total pagado por cada uno de los eventos registrados
SELECT 
  e.id_evento,
  e.nombre_evento,
  fn_total_pagado_evento(e.id_evento) AS total_pagado
FROM eventos e;

-- función #2 para saber el total por pagar de un evento
DELIMITER $$

CREATE FUNCTION fn_total_por_pagar_evento(p_evento INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_pagado DECIMAL(10,2);
  DECLARE total_servicios DECIMAL(10,2);

  -- total pagado confirmado
  SELECT IFNULL(SUM(monto), 0)
  INTO total_pagado
  FROM pagos
  WHERE id_evento = p_evento
    AND pagado = TRUE;

  -- total de servicios contratados
  SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
  INTO total_servicios
  FROM eventos_servicios
  WHERE id_evento = p_evento;

  -- devolver saldo pendiente
  RETURN total_servicios - total_pagado;
END$$
DELIMITER ;
-- consulta para la funcion fn_total_por_pagar 
SELECT fn_total_por_pagar_evento(1);


-- consulta para saber si hay algun evento sin pagar completamente
SELECT 
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.nombre_evento,
  COALESCE(te.total_servicios, 0) AS total_servicios,
  COALESCE(tp.total_pagado, 0)    AS total_pagado,
  COALESCE(te.total_servicios, 0) - COALESCE(tp.total_pagado, 0) AS saldo_pendiente
FROM eventos e
JOIN clientes c ON c.id_cliente = e.id_cliente
LEFT JOIN (
  SELECT id_evento, SUM(cantidad * precio_unitario) AS total_servicios
  FROM eventos_servicios
  GROUP BY id_evento
) te ON te.id_evento = e.id_evento
LEFT JOIN (
  SELECT id_evento, SUM(monto) AS total_pagado
  FROM pagos
  WHERE pagado = TRUE  
  GROUP BY id_evento
) tp ON tp.id_evento = e.id_evento
WHERE (COALESCE(te.total_servicios, 0) - COALESCE(tp.total_pagado, 0)) > 0
ORDER BY e.id_evento;

-- Eventos totalmente pagados
SELECT 
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.nombre_evento,
  COALESCE(te.total_servicios, 0) AS total_servicios,
  COALESCE(tp.total_pagado, 0)    AS total_pagado,
  COALESCE(te.total_servicios, 0) - COALESCE(tp.total_pagado, 0) AS saldo_pendiente
FROM eventos e
JOIN clientes c ON c.id_cliente = e.id_cliente
LEFT JOIN (
  SELECT id_evento, SUM(cantidad * precio_unitario) AS total_servicios
  FROM eventos_servicios
  GROUP BY id_evento
) te ON te.id_evento = e.id_evento
LEFT JOIN (
  SELECT id_evento, SUM(monto) AS total_pagado
  FROM pagos
  WHERE pagado = TRUE
  GROUP BY id_evento
) tp ON tp.id_evento = e.id_evento
WHERE (COALESCE(te.total_servicios, 0) - COALESCE(tp.total_pagado, 0)) = 0
ORDER BY e.id_evento;

-- funcion #3 para conocerl el porcentaje pagado de un evento
DELIMITER $$

CREATE FUNCTION fn_porcentaje_pagado_evento(p_evento INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_pagado DECIMAL(10,2);
    DECLARE total_del_evento DECIMAL(10,2);
    DECLARE porcentaje DECIMAL(5,2);

    -- total pagado confirmado
    SELECT IFNULL(SUM(monto), 0)
    INTO total_pagado
    FROM pagos
    WHERE id_evento = p_evento
      AND pagado = TRUE;

    -- total de servicios contratados
    SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
    INTO total_del_evento
    FROM eventos_servicios
    WHERE id_evento = p_evento;

    -- calcular porcentaje
    IF total_del_evento = 0 THEN
        SET porcentaje = 0;
    ELSE
        SET porcentaje = (total_pagado / total_del_evento) * 100;
    END IF;

    RETURN porcentaje;
END$$
DELIMITER ;


-- consulta para la funcion de porcentaje pagado del evento
SELECT fn_porcentaje_pagado_evento(3);
    
