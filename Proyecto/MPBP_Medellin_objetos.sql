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

-- vista de servicios mas contratados
-- esta vista nos muestra los servicios mas contratados por los clientes, ordenados de mayor a menor
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

-- Vista para el total gastado por cada cliente
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


-- Vista para el estado de pago de cada evento
-- Esta vista muestra el estado de pago de cada evento, indicando si está pagado o pendiente
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