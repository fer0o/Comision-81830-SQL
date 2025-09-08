-- usamos la base de datos de MPBP_Medellin
USE MPBP_Medellin;

-- vista de eventos x cliente
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
  SUM(es.subtotal) AS costo_total
FROM eventos e
JOIN clientes c ON e.id_cliente = c.id_cliente
JOIN eventos_servicios es ON e.id_evento = es.id_evento
GROUP BY e.id_evento;

-- consulta para vista de eventos por cliente
SELECT * FROM vista_eventos_por_cliente;

CREATE VIEW vista_servicios_mas_contratados AS
SELECT
  s.id_servicio,
  s.nombre_servicio,
  COUNT(es.id_evento_servicio) AS veces_contratado,
  SUM(es.cantidad) AS cantidad_total
FROM servicios s
JOIN eventos_servicios es ON s.id_servicio = es.id_servicio
GROUP BY s.id_servicio, s.nombre_servicio
ORDER BY cantidad_total DESC;

SELECT * FROM vista_servicios_mas_contratados;


CREATE VIEW vista_total_gastado_por_cliente AS
SELECT 
  c.id_cliente,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  COUNT(DISTINCT e.id_evento) AS total_eventos,
  SUM(es.cantidad * es.precio_unitario) AS total_gastado
FROM clientes c
JOIN eventos e ON c.id_cliente = e.id_cliente
JOIN eventos_servicios es ON e.id_evento = es.id_evento
GROUP BY c.id_cliente, cliente
ORDER BY total_gastado DESC;

SELECT * FROM vista_total_gastado_por_cliente;

-- Clientes que han gastado más de $50,000
SELECT * FROM vista_total_gastado_por_cliente
WHERE total_gastado > 50000;



CREATE VIEW vista_estado_pago_evento AS
SELECT
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.nombre_evento,
  IFNULL(SUM(DISTINCT es.cantidad * es.precio_unitario), 0) AS total_servicios,
  IFNULL(SUM(DISTINCT p.monto), 0) AS total_pagado,
  CASE
    WHEN IFNULL(SUM(DISTINCT p.monto), 0) >= IFNULL(SUM(DISTINCT es.cantidad * es.precio_unitario), 0)
      THEN 'Pagado'
    ELSE 'Pendiente'
  END AS estado_pago
FROM eventos e
JOIN clientes c ON e.id_cliente = c.id_cliente
LEFT JOIN eventos_servicios es ON e.id_evento = es.id_evento
LEFT JOIN pagos p ON e.id_evento = p.id_evento
GROUP BY e.id_evento, c.nombre, c.apellido, e.nombre_evento;

SELECT * FROM vista_estado_pago_evento;

-- consulta de los eventos que no estan pagados completamente
SELECT *
FROM vista_estado_pago_evento
WHERE estado_pago = 'Pendiente';

-- funcion para saber el total pagado por un evento por id
DELIMITER $$

CREATE FUNCTION fn_total_pagado_evento(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT IFNULL(SUM(monto), 0)
  INTO total
  FROM pagos
  WHERE id_evento = id;

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

-- función para saber el total por pagar de un evento
DELIMITER $$

CREATE FUNCTION fn_total_por_pagar_evento(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_pagado DECIMAL(10,2);
  DECLARE total_servicios DECIMAL(10,2);
  DECLARE total_por_pagar DECIMAL(10,2);

  -- obtener total pagado para ese evento
  SELECT IFNULL(SUM(monto), 0)
  INTO total_pagado
  FROM pagos
  WHERE id_evento = id;

  -- obtener total de servicios contratados en ese evento
  SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
  INTO total_servicios
  FROM eventos_servicios
  WHERE id_evento = id;

  -- calcular diferencia
  SET total_por_pagar = total_servicios - total_pagado;

  RETURN total_por_pagar;
END$$

DELIMITER ;
-- consulta para la funcion fn_total_por_pagar 
SELECT fn_total_por_pagar_evento(7);

-- consulta para saber si hay algun evento sin pagar ompletamente
SELECT 
  e.id_evento,
  CONCAT(c.nombre, ' ', c.apellido) AS cliente,
  e.nombre_evento,
  IFNULL(SUM(es.cantidad * es.precio_unitario), 0) AS total_servicios,
  IFNULL(SUM(p.monto), 0) AS total_pagado,
  (IFNULL(SUM(es.cantidad * es.precio_unitario), 0) - IFNULL(SUM(p.monto), 0)) AS saldo_pendiente
FROM eventos e
JOIN clientes c ON e.id_cliente = c.id_cliente
LEFT JOIN eventos_servicios es ON e.id_evento = es.id_evento
LEFT JOIN pagos p ON e.id_evento = p.id_evento
GROUP BY e.id_evento, cliente, e.nombre_evento
HAVING saldo_pendiente > 0;

-- funcion del porcentaje pagado de un evento
DELIMITER $$
CREATE FUNCTION fn_porcentaje_pagado_evento(id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_pagado DECIMAL(10,2);
    DECLARE total_del_evento DECIMAL(10,2);
    DECLARE porcentaje DECIMAL(5,2);
    -- obtener total pagado para ese evento
    SELECT IFNULL(SUM(monto), 0)
    INTO total_pagado
    FROM pagos
    WHERE id_evento = id;
    -- obtener total de servicios contratados en ese evento
    SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
    INTO total_del_evento
    FROM eventos_servicios
    WHERE id_evento = id;
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
    
