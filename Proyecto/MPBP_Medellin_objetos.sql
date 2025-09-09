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

-- SP #1 registrar pagos 
DELIMITER $$

CREATE PROCEDURE sp_registrar_pago(
  IN  p_evento INT,
  IN  p_fecha DATETIME,
  IN  p_monto DECIMAL(10,2),
  IN  p_metodo ENUM('efectivo','transferencia','tarjeta','cheque'),
  IN  p_tipo   ENUM('anticipo','parcial','liquidacion'),
  IN  p_referencia VARCHAR(120),
  IN  p_notas VARCHAR(300),
  OUT p_id_pago INT,
  OUT p_saldo_nuevo DECIMAL(12,2)
)
MODIFIES SQL DATA
BEGIN
  DECLARE v_saldo         DECIMAL(12,2);
  DECLARE v_fecha_evento  DATETIME;
  DECLARE v_ref_count     INT;

  -- 1) Validaciones básicas
  IF p_monto <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto debe ser > 0';
  END IF;

  -- 2) Verificar que el evento exista y traer su fecha
  SELECT fecha_evento INTO v_fecha_evento
  FROM eventos
  WHERE id_evento = p_evento
  LIMIT 1;

  IF v_fecha_evento IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El evento no existe';
  END IF;

  -- 3) Reglas temporales por tipo de pago
  IF p_tipo = 'anticipo' AND p_fecha >= v_fecha_evento THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El anticipo debe ser antes del evento';
  END IF;

  IF p_tipo = 'liquidacion' AND p_fecha < v_fecha_evento THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La liquidación no puede ser antes del evento';
  END IF;

  -- 4) Referencia (si viene), validar duplicados
  IF p_referencia IS NOT NULL AND p_referencia <> '' THEN
    SELECT COUNT(*) INTO v_ref_count
    FROM pagos
    WHERE referencia = p_referencia;

    IF v_ref_count > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La referencia ya existe';
    END IF;
  END IF;

  -- 5) Validar que no haya sobrepago usando tu función
  SET v_saldo = fn_total_por_pagar_evento(p_evento);
  IF p_monto > v_saldo THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto excede el saldo pendiente';
  END IF;

  -- 6) Transacción para asegurar consistencia
  START TRANSACTION;
    INSERT INTO pagos (
      id_evento, fecha_pago, monto, metodo_pago, tipo_pago, referencia, pagado, notas
    ) VALUES (
      p_evento, p_fecha, p_monto, p_metodo, p_tipo, p_referencia, TRUE, p_notas
    );

    SET p_id_pago = LAST_INSERT_ID();
    SET p_saldo_nuevo = fn_total_por_pagar_evento(p_evento);
  COMMIT;
END$$

DELIMITER ;
    
SET @id_pago := NULL; SET @saldo := NULL;

-- Evento 16: anticipo 20,000
CALL sp_registrar_pago(16, '2026-03-20 12:00:00', 20000.00, 'transferencia', 'anticipo', 'REF-16-A1', 'Anticipo', @id_pago, @saldo);
SELECT @id_pago AS id_pago_16_a1, @saldo AS saldo_16;

-- Evento 17: anticipo 25,000
CALL sp_registrar_pago(17, '2026-05-15 10:00:00', 25000.00, 'tarjeta', 'anticipo', 'REF-17-A1', 'Anticipo', @id_pago, @saldo);
SELECT @id_pago AS id_pago_17_a1, @saldo AS saldo_17;

-- Evento 18: anticipo 10,000
CALL sp_registrar_pago(18, '2026-04-15 09:00:00', 10000.00, 'efectivo', 'anticipo', 'REF-18-A1', 'Anticipo', @id_pago, @saldo);
SELECT @id_pago AS id_pago_18_a1, @saldo AS saldo_18;

-- Evento 19: anticipo 15,000
CALL sp_registrar_pago(19, '2026-06-25 11:00:00', 15000.00, 'transferencia', 'anticipo', 'REF-19-A1', 'Anticipo', @id_pago, @saldo);
SELECT @id_pago AS id_pago_19_a1, @saldo AS saldo_19;

-- consulta para saber el saldo pendiente los eventos 16,17,18,19 ultimos agregados
SELECT 
  e.id_evento,
  e.nombre_evento,
  COALESCE(te.total_evento, 0)  AS total_evento,
  COALESCE(tp.total_pagado, 0)  AS total_pagado,
  COALESCE(te.total_evento, 0) - COALESCE(tp.total_pagado, 0) AS saldo_pendiente
FROM eventos e
LEFT JOIN (
  SELECT id_evento, SUM(subtotal) AS total_evento
  FROM eventos_servicios
  GROUP BY id_evento
) te ON te.id_evento = e.id_evento
LEFT JOIN (
  SELECT id_evento, SUM(monto) AS total_pagado
  FROM pagos
  WHERE pagado = TRUE
  GROUP BY id_evento
) tp ON tp.id_evento = e.id_evento
WHERE e.id_evento IN (16,17,18,19)
ORDER BY e.id_evento;