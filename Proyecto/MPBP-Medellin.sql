-- creamos la base de datos
CREATE DATABASE IF NOT EXISTS MPBP_Medellin;
-- usamos la base de datos
USE MPBP_Medellin;

-- creamos la tabla clientes
CREATE TABLE IF NOT EXISTS clientes  (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(120) NOT NULL,
apellido VARCHAR(120) NOT NULL,
email VARCHAR (150) UNIQUE,
telefono VARCHAR(20),
direccion VARCHAR(200)
);
-- poblamos la tabla con valores
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES
('Ana', 'García', 'ana.garcia@example.com', '3310000001', 'Av. Central 123, Guadalajara, Jalisco'),
('Luis', 'Pérez', 'luis.perez@example.com', '3310000002', 'Calle Reforma 45, Zapopan, Jalisco'),
('Marta', 'Luna', 'marta.luna@example.com', '3310000003', 'Av. Vallarta 567, Guadalajara, Jalisco'),
('Carlos', 'Sánchez', 'carlos.sanchez@example.com', '3310000004', 'Calle Hidalgo 89, Tlaquepaque, Jalisco'),
('Laura', 'Romero', 'laura.romero@example.com', '3310000005', 'Av. México 222, Zapopan, Jalisco'),
('Pedro', 'Gómez', 'pedro.gomez@example.com', '3310000006', 'Calle Juárez 101, Guadalajara, Jalisco'),
('Sofía', 'Navarro', 'sofia.navarro@example.com', '3310000007', 'Av. Patria 12, Zapopan, Jalisco'),
('Diego', 'Martínez', 'diego.martinez@example.com', '3310000008', 'Calle López Mateos 345, Guadalajara, Jalisco'),
('Patricia', 'Hernández', 'patricia.hernandez@example.com', '3310000009', 'Av. Chapultepec 678, Guadalajara, Jalisco'),
('Jorge', 'Torres', 'jorge.torres@example.com', '3310000010', 'Calle Independencia 90, Tonalá,Jalisco'),
('Ricardo', 'Vargas', 'ricardo.vargas@example.com', '3310000011', 'Calle Morelos 145, Guadalajara, Jalisco'),
('Elena', 'Castro', 'elena.castro@example.com', '3310000012', 'Av. López Mateos 234, Zapopan, Jalisco'),
('Fernando', 'Morales', 'fernando.morales@example.com', '3310000013', 'Calle Constitución 456, Tlaquepaque, Jalisco'),
('Gabriela', 'Ríos', 'gabriela.rios@example.com', '3310000014', 'Av. Revolución 789, Tonalá, Jalisco'),
('Héctor', 'Domínguez', 'hector.dominguez@example.com', '3310000015', 'Calle Benito Juárez 321, Guadalajara, Jalisco');

-- consulta primer tabla
select * from clientes;

-- creacion de tabla servicios
CREATE TABLE IF NOT EXISTS servicios (
id_servicio INT PRIMARY KEY AUTO_INCREMENT,
tipo_servicio ENUM ('comida', 'musica', 'personal', 'ambientacion')NOT NULL,
nombre_servicio VARCHAR(100)NOT NULL,
activo TINYINT(1) DEFAULT 1
);

-- poblamos la tabla servicios
INSERT INTO servicios (tipo_servicio, nombre_servicio, activo) VALUES
-- Comida
('comida', 'Banquete Premium', 1),
('comida', 'Banquete Tradicional', 1),
('comida', 'Menú Infantil', 1),
('comida', 'Buffet Libre', 1),
('comida', 'Mesa de Postres', 1),

-- Música
('musica', 'DJ Gold', 1),
('musica', 'Banda de Jazz', 1),
('musica', 'Mariachi Tradicional', 1),
('musica', 'Cuarteto de Cuerdas', 1),
('musica', 'Saxofonista Solista', 1),

-- Personal
('personal', 'Mesero', 1),
('personal', 'Chef Ejecutivo', 1),
('personal', 'Bartender', 1),
('personal', 'Coordinador de Evento', 1),
('personal', 'Técnico de Iluminación', 1),

-- Ambientación
('ambientacion', 'Decoración Floral Premium', 1),
('ambientacion', 'Decoración Temática', 1),
('ambientacion', 'Iluminación LED de Escenario', 1),
('ambientacion', 'Letras Gigantes Iluminadas', 1),
('ambientacion', 'Photobooth / Cabina de Fotos', 1);

-- consulta tabla servicios
select * from servicios;

-- creacion de tabla empleados
CREATE TABLE IF NOT EXISTS empleados(
id_empleado INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (120) NOT NULL,
apellido VARCHAR (120) NOT NULL,
email VARCHAR(150) UNIQUE,
telefono VARCHAR(20),
puesto VARCHAR (50)
);

-- poblamos la tabla empleados
INSERT INTO empleados (nombre, apellido, email, telefono, puesto) VALUES
-- Meseros
('Ana', 'García', 'ana.garcia@mpbp.com', '3310000001', 'Mesero'),
('Luis', 'Pérez', 'luis.perez@mpbp.com', '3310000002', 'Mesero'),
('María', 'Hernández', 'maria.hernandez@mpbp.com', '3310000003', 'Mesero'),

-- Chefs
('Carlos', 'Sánchez', 'carlos.sanchez@mpbp.com', '3310000004', 'Chef Ejecutivo'),
('Patricia', 'Romero', 'patricia.romero@mpbp.com', '3310000005', 'Chef Ejecutivo'),

-- Bartenders
('Jorge', 'Torres', 'jorge.torres@mpbp.com', '3310000006', 'Bartender'),
('Fernanda', 'Luna', 'fernanda.luna@mpbp.com', '3310000007', 'Bartender'),

-- Coordinadores y técnicos
('Ricardo', 'Vargas', 'ricardo.vargas@mpbp.com', '3310000008', 'Coordinador de Evento'),
('Gabriela', 'Ríos', 'gabriela.rios@mpbp.com', '3310000009', 'Coordinador de Evento'),
('Héctor', 'Domínguez', 'hector.dominguez@mpbp.com', '3310000010', 'Técnico de Iluminación'),

-- DJs y músicos
('Marta', 'Luna', 'marta.luna@mpbp.com', '3310000011', 'DJ'),
('Pablo', 'Castro', 'pablo.castro@mpbp.com', '3310000012', 'DJ'),
('Elena', 'Morales', 'elena.morales@mpbp.com', '3310000013', 'Saxofonista'),

-- Personal de limpieza
('Diego', 'Martínez', 'diego.martinez@mpbp.com', '3310000014', 'Personal de Limpieza'),
('Sofía', 'Navarro', 'sofia.navarro@mpbp.com', '3310000015', 'Personal de Limpieza');

-- consulta tabla empleados
select * from empleados;

-- creacion tabla de eventos (importante) 
CREATE TABLE IF NOT EXISTS eventos (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_evento VARCHAR(120),
    fecha_evento DATETIME NOT NULL,
    tipo_evento ENUM('boda','graduacion','cumpleanios','corporativo','otro') NOT NULL,
    lugar VARCHAR(150),
    id_cliente INT NOT NULL,

    CONSTRAINT fk_eventos_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_eventos_fecha (fecha_evento),
    INDEX idx_eventos_tipo (tipo_evento),
    INDEX idx_eventos_cliente (id_cliente)
);
-- poblamos la tabla eventos
INSERT INTO eventos (nombre_evento, fecha_evento, tipo_evento, lugar, id_cliente) VALUES
('Boda García-Pérez', '2025-02-14 19:00:00', 'boda', 'Salón Real del Lago', 1),
('Graduación Ingeniería 2025', '2025-06-20 18:00:00', 'graduacion', 'Centro de Convenciones Guadalajara', 2),
('Cumpleaños Sofía Navarro', '2025-03-05 15:00:00', 'cumpleanios', 'Quinta Los Olivos', 3),
('Evento Corporativo MPBP', '2025-05-10 09:00:00', 'corporativo', 'Hotel Fiesta Americana', 4),
('Boda Luna-Romero', '2025-04-18 17:00:00', 'boda', 'Hacienda Santa María', 5),
('Graduación Medicina 2025', '2025-07-12 18:30:00', 'graduacion', 'Centro Cultural Universitario', 6),
('Cumpleaños Jorge Torres', '2025-08-25 14:00:00', 'cumpleanios', 'Jardín Las Flores', 7),
('Evento Corporativo Innovatech', '2025-09-15 10:00:00', 'corporativo', 'Expo Guadalajara', 8),
('Boda Morales-Castro', '2025-10-03 18:00:00', 'boda', 'Salón La Casona', 9),
('Graduación Derecho 2025', '2025-11-28 19:00:00', 'graduacion', 'Teatro Diana', 10),
('Cumpleaños Diego Martínez', '2025-12-02 13:00:00', 'cumpleanios', 'Casa de Campo San Pedro', 11),
('Evento Corporativo TecnoGlobal', '2025-12-15 09:30:00', 'corporativo', 'Centro Empresarial JVC', 12),
('Boda Ríos-Domínguez', '2026-01-24 17:30:00', 'boda', 'Hacienda Los Arcos', 13),
('Graduación Contaduría 2026', '2026-02-20 18:00:00', 'graduacion', 'Centro de Convenciones Expo Plaza', 14),
('Cumpleaños Héctor Domínguez', '2026-03-10 15:30:00', 'cumpleanios', 'Salón Jardín Primavera', 15);

-- consulta eventos
select * from eventos;

-- creacion tabla eventos_servicios conexion de FK con servicios y con eventos
-- id_evento (FK a eventos.id_evento)
-- id_servicio (FK a servicios.id_servicio)
-- fk = foreign key
-- ev_srv = eventos_servicios
-- evento = tabla de destino
CREATE TABLE IF NOT EXISTS eventos_servicios (
    id_evento_servicio INT PRIMARY KEY AUTO_INCREMENT,
    id_evento INT NOT NULL,
    id_servicio INT NOT NULL,
    cantidad INT DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    CONSTRAINT fk_ev_srv_evento
        FOREIGN KEY (id_evento)
        REFERENCES eventos(id_evento)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_ev_srv_servicio
        FOREIGN KEY (id_servicio)
        REFERENCES servicios(id_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    INDEX idx_ev_srv_evento (id_evento),
    INDEX idx_ev_srv_servicio (id_servicio)
);
-- consulta de un total de un evento
SELECT es.id_evento, SUM(es.subtotal) AS total_evento
FROM eventos_servicios es
WHERE es.id_evento = 1
GROUP BY es.id_evento;
-- consulta del total de cada servicio contratado
SELECT s.tipo_servicio, s.nombre_servicio, es.cantidad, es.precio_unitario, es.subtotal
FROM eventos_servicios es
JOIN servicios s ON s.id_servicio = es.id_servicio
WHERE es.id_evento = 1
ORDER BY s.tipo_servicio, s.nombre_servicio;

select * from eventos_servicios;

-- poblamos la tabla eventos_servicios
-- id_evento, id_servicio, cantidad, precio_unitario

-- Evento 1: Boda
-- Banquete Premium
-- Mesero x10
-- DJ Gold
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(1, 1, 1, 45000.00),
(1, 11, 10, 300.00), 
(1, 6, 1, 8500.00);

-- Evento 2: Graduación
-- Buffet Libre
-- Banda de Jazz
 -- Coordinador de Evento
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(2, 4, 1, 38000.00),
(2, 7, 1, 12000.00),
(2, 14, 1, 800.00);

-- Evento 3: Cumpleaños
-- Menú Infantil
-- Mesa de Postres
 -- Photobooth
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(3, 3, 1, 8000.00),
(3, 5, 1, 9000.00),
(3, 20, 1, 6000.00);


-- Evento 4: Corporativo
-- Banquete Tradicional
-- Bartender x2
-- Iluminación LED de Escenario
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(4, 2, 1, 30000.00),
(4, 13, 2, 400.00),
(4, 18, 1, 7000.00);

-- Evento 5: Boda
-- Banquete Premium
-- Mariachi Tradicional
-- Decoración Floral Premium
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(5, 1, 1, 45000.00),
(5, 8, 1, 9000.00),
(5, 16, 1, 6000.00);

-- Evento 6: Graduación
-- Buffet Libre
-- Cuarteto de Cuerdas
-- Mesero x12
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(6, 4, 1, 38000.00),
(6, 9, 1, 7000.00),
(6, 11, 12, 300.00);

-- Evento 7: Cumpleaños
-- Banquete Tradicional
-- Saxofonista Solista
-- Letras Gigantes Iluminadas
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(7, 2, 1, 30000.00),
(7, 10, 1, 5000.00),
(7, 19, 1, 3500.00);

-- Evento 8: Corporativo
 -- Coordinador de Evento
  -- Técnico de Iluminación x2
  -- DJ Gold
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(8, 14, 1, 800.00),
(8, 15, 2, 500.00),
(8, 6, 1, 8500.00);

-- Evento 9: Boda
-- Banquete Premium
-- Decoración Temática
-- Mesa de Postres
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(9, 1, 1, 45000.00),
(9, 17, 1, 8000.00),
(9, 5, 1, 9000.00);

-- Evento 10: Graduación
 -- Banquete Tradicional
 -- Banda de Jazz
 -- Bartender x3
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(10, 2, 1, 30000.00),
(10, 7, 1, 12000.00),
(10, 13, 3, 400.00);
-- Evento 11: Cumpleaños
-- Menú Infantil
-- Animador Infantil
-- Decoración Temática
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(11, 3, 1, 8000.00),
(11, 12, 1, 2500.00),
(11, 17, 1, 8000.00);

-- Evento 12: Corporativo
-- Buffet Libre
-- DJ Gold
-- Iluminación LED de Escenario
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(12, 4, 1, 38000.00),
(12, 6, 1, 8500.00),
(12, 18, 1, 7000.00);

-- Evento 13: Boda
-- Banquete Premium
-- Cuarteto de Cuerdas
-- Decoración Floral Premium
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(13, 1, 1, 45000.00),
(13, 9, 1, 7000.00),
(13, 16, 1, 6000.00);

-- Evento 14: Graduación
-- Banquete Tradicional
-- Mariachi Tradicional
-- Bartender x2
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(14, 2, 1, 30000.00),
(14, 8, 1, 9000.00),
(14, 13, 2, 400.00);

-- Evento 15: Cumpleaños
-- Mesa de Postres
-- Saxofonista Solista
-- Photobooth
INSERT INTO eventos_servicios (id_evento, id_servicio, cantidad, precio_unitario) VALUES
(15, 5, 1, 9000.00),
(15, 10, 1, 5000.00),
(15, 20, 1, 6000.00);

-- consulta de eventos _servicios
select * from eventos_servicios;




-- creacion tabla eventos_empleados (N:M eventos y empleados)
-- id_evento (FK a eventos.id_evento)
-- id_empleado (FK a empleado.id_empleado)
-- fk = foreign key
-- ev_emp = eventos_empleados
-- evento / empleado = tabla de destino
-- horas_estimadas pensando en como manejar los costos de los eventos y sueldos de empleados ....
CREATE TABLE IF NOT EXISTS eventos_empleados(
id_evento_empleado INT PRIMARY KEY AUTO_INCREMENT,
id_evento INT NOT NULL,
id_empleado INT NOT NULL,
rol_en_evento VARCHAR (50) NOT NULL,
horas_estimadas DECIMAL (5,2),
notas VARCHAR (200),
	CONSTRAINT fk_ev_emp_evento
		FOREIGN KEY (id_evento)
        REFERENCES eventos (id_evento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
	CONSTRAINT fk_ev_emp_empleado
		FOREIGN KEY (id_empleado)
        REFERENCES empleados(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	INDEX idx_ev_emp_evento (id_evento),
    INDEX idx_ev_emp_empleado (id_empleado),
    
    UNIQUE KEY uq_evento_empleado_rol (id_evento, id_empleado, rol_en_evento)
);
-- Evento 1: Boda García-Pérez
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(1, 1, 'Coordinador/a de evento', 8, 'Supervisa todo el evento'),
(1, 2, 'Chef', 6, 'Banquete principal'),
(1, 3, 'Mesero', 7, 'Servicio de mesas'),
(1, 4, 'Mesero', 7, 'Servicio de mesas'),
(1, 5, 'DJ', 5, 'Ameniza la fiesta');
-- Evento 2: Graduación Ingeniería 2025
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(2, 9,  'Coordinador de Evento', 8.00, 'Recepción y Presentador de evento'),
(2, 5,  'Chef Ejecutivo', 6.00, 'Buffet'),
(2, 1,  'Mesero', 6.50, 'Zona A'),
(2, 3,  'Mesero', 6.50, 'Zona B'),
(2, 12, 'DJ', 5.00, 'Ambiente general musica tranquila');
-- Evento 3: Cumpleaños Sofía Navarro (XV años)
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(3, 8,  'Coordinador de Evento', 6.00, 'Presentador del evento y coordinador'),
(3, 4,  'Chef Ejecutivo', 5.00, 'Menú'),
(3, 3,  'Mesero', 5.50, 'Apoyo en servicio'),
(3, 13, 'Saxofonista',2.50, 'Intermedios musicales');

-- Evento 4: Evento Corporativo MPBP (fiesta aniversario)
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(4, 9,  'Coordinador de Evento', 8.00, 'Protocolo corporativo'),
(4, 6,  'Bartender',6.00, 'Bar principal'),
(4, 7,  'Bartender',6.00, 'Bar secundario'),
(4, 10, 'Técnico de Iluminación',6.50, 'Iluminación de escenario'),
(4, 11, 'DJ',5.00, 'Música en vivo para fiesta de aniversario');

-- Evento 5: Boda Luna-Romero
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(5, 8,  'Coordinador de Evento', 8.00, 'Ceremonia y recepción'),
(5, 4,  'Chef Ejecutivo', 7.50, 'Banquete'),
(5, 1,  'Mesero', 7.00, 'Mesa novios'),
(5, 2,  'Mesero', 7.00, 'Zona invitados'),
(5, 11, 'DJ', 5.50, 'Fiesta');

-- Evento 6: Graduación Medicina 2025
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(6, 9,  'Coordinador de Evento', 8.00, 'Ceremonia y coctel'),
(6, 5,  'Chef Ejecutivo', 6.50, 'Buffet'),
(6, 2,  'Mesero', 6.50, 'Salón A'),
(6, 3,  'Mesero', 6.50, 'Salón B'),
(6, 10, 'Técnico de Iluminación',6.50, 'Escenario principal');

-- Evento 7: Cumpleaños Jorge Torres
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(7, 8,  'Coordinador de Evento', 6.00, 'Coordinación general'),
(7, 4,  'Chef Ejecutivo', 5.50, 'Banquete tradicional'),
(7, 1,  'Mesero', 5.50, 'Servicio'),
(7, 13, 'Saxofonista', 2.50, 'Show musical');

-- Evento 8: Evento Corporativo Innovatech
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(8, 9,  'Coordinador de Evento', 8.00, 'Protocolo y agenda'),
(8, 6,  'Bartender', 6.00, 'Bar VIP'),
(8, 10, 'Técnico de Iluminación',7.00, 'Iluminación general'),
(8, 12, 'DJ', 4.50, 'Música de fondo');

-- Evento 9: Boda Morales-Castro
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(9, 8,  'Coordinador de Evento', 8.00, 'Ceremonia y banquete'),
(9, 5,  'Chef Ejecutivo', 7.50, 'Cocina'),
(9, 2,  'Mesero', 7.00, 'Servicio'),
(9, 3,  'Mesero', 7.00, 'Servicio'),
(9, 11, 'DJ', 5.50, 'Pista de baile musica para bailar preferencia cumbias');

-- Evento 10: Graduación Derecho 2025
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(10, 9,  'Coordinador de Evento', 8.00, 'Ceremonia y entrega de diplomas'),
(10, 4,  'Chef Ejecutivo', 6.50, 'Banquete'),
(10, 1,  'Mesero', 6.50, 'Zona A'),
(10, 3,  'Mesero', 6.50, 'Zona B'),
(10, 7,  'Bartender', 5.50, 'Coctelería');

-- Evento 11: Cumpleaños Diego Martínez
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(11, 8,  'Coordinador de Evento', 5.50, 'Evento familiar'),
(11, 4,  'Chef Ejecutivo', 5.00, 'Mesa de postres'),
(11, 1,  'Mesero', 5.00, 'Servicio'),
(11, 12, 'DJ', 3.50, 'Ambientación');

-- Evento 12: Evento Corporativo TecnoGlobal
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(12, 9,  'Coordinador de Evento', 8.00, 'Protocolo corporativo'),
(12, 6,  'Bartender', 6.00, 'Bar principal'),
(12, 10, 'Técnico de Iluminación',7.00, 'Iluminación escenario'),
(12, 11, 'DJ', 4.50, 'Música ambiente');

-- Evento 13: Boda Ríos-Domínguez
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(13, 8,  'Coordinador de Evento', 8.00, 'Logística general'),
(13, 5,  'Chef Ejecutivo', 7.50, 'Banquete'),
(13, 2,  'Mesero', 7.00, 'Servicio'),
(13, 3,  'Mesero', 7.00, 'Servicio'),
(13, 12, 'DJ', 5.50, 'Fiesta');

-- Evento 14: Graduación Contaduría 2026
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(14, 9,  'Coordinador de Evento', 8.00, 'Ceremonia y brindis'),
(14, 4,  'Chef Ejecutivo', 6.50, 'Banquete'),
(14, 1,  'Mesero', 6.50, 'Zona A'),
(14, 3,  'Mesero', 6.50, 'Zona B'),
(14, 7,  'Bartender', 5.50, 'Bar general');

-- Evento 15: Cumpleaños Héctor Domínguez
INSERT INTO eventos_empleados (id_evento, id_empleado, rol_en_evento, horas_estimadas, notas) VALUES
(15, 8,  'Coordinador de Evento', 5.50, 'Apoyo general'),
(15, 4,  'Chef Ejecutivo', 5.00, 'Mesa de postres'),
(15, 2,  'Mesero', 5.00, 'Servicio'),
(15, 13, 'Saxofonista', 2.50, 'Show musical');

-- consulta general
select * from eventos_empleados;
-- consulta especificando los detalles del evento con los empleados y roles
SELECT * 
FROM eventos_empleados ee
LEFT JOIN eventos e ON ee.id_evento = e.id_evento
LEFT JOIN empleados em ON ee.id_empleado = em.id_empleado;
-- consulta de horas totales por evento
SELECT e.nombre_evento, SUM(horas_estimadas) AS total_horas
FROM eventos_empleados ee
JOIN eventos e ON ee.id_evento = e.id_evento
GROUP BY e.nombre_evento;

-- creacion tabla proveedores (proveedores externos)
CREATE TABLE IF NOT EXISTS proveedores (
id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
nombre_proveedor VARCHAR(150) NOT NULL,
contacto VARCHAR(120),
telefono VARCHAR(20),
email VARCHAR(150) UNIQUE,
direccion VARCHAR(200),
tipo_servicio ENUM( 'banquete','bebidas','musica','audio','iluminacion','decoracion','ambientacion','mobiliario','fotografia') NOT NULL,
activo BOOLEAN NOT NULL DEFAULT TRUE, 
CHECK (activo IN (0,1)),

INDEX idx_prov_nombre (nombre_proveedor),
INDEX idx_prov_tipo (tipo_servicio)
);

-- poblamos la tabla proveedores
INSERT INTO proveedores 
(nombre_proveedor, contacto, telefono, email, direccion, tipo_servicio, activo) VALUES
('Banquetes Del Lago', 'María López', '555-123-4567', 'contacto@mpbp.com', 'Av. Lago 123, Guadalajara', 'banquete', TRUE),
('Bebidas y Cócteles Elite', 'Juan Pérez', '555-234-5678', 'ventas@mpbp.com', 'Calle Brisas 45, Zapopan', 'bebidas', TRUE),
('Sonido y Música Pro', 'Luis Hernández', '555-345-6789', 'musica@mpbp.com', 'Av. Sonora 567, Guadalajara', 'musica', TRUE),
('AudioMax Solutions', 'Ana Torres', '555-456-7890', 'audio@mpbp.com', 'Blvd. Tecnológico 12, Tlaquepaque', 'audio', TRUE),
('Iluminación Escénica MX', 'Pedro García', '555-567-8901', 'iluminacion@mpbp.com', 'Av. Luces 90, Zapopan', 'iluminacion', TRUE),
('Florería y Decoración Primavera', 'Carmen Martínez', '555-678-9012', 'decoracion@mpbp.com', 'Calle Gardenias 22, Guadalajara', 'decoracion', TRUE),
('Ambienta Eventos', 'Diego Ruiz', '555-789-0123', 'ambientacion@mpbp.com', 'Av. Ambiente 15, Guadalajara', 'ambientacion', TRUE),
('Mobiliario Elegante', 'Patricia Sánchez', '555-890-1234', 'mobiliario@mpbp.com', 'Calle Roble 34, Zapopan', 'mobiliario', TRUE),
('Fotografía Moments', 'Héctor Romero', '555-901-2345', 'fotografia@mpbp.com', 'Av. Imagen 55, Tlaquepaque', 'fotografia', TRUE),
('DecorArte Eventos', 'Laura Mendoza', '555-222-3344', 'decorarte@mpbp.com', 'Av. Fiesta 120, Guadalajara', 'decoracion', FALSE),
('Luz y Sonido Fiesta', 'Marco Castillo', '555-333-4455', 'luzsonido@mpbp.com', 'Calle Música 88, Zapopan', 'audio', FALSE),
('Banquetes Gourmet Select', 'Sofía Vargas', '555-012-3456', 'banquetes@mpbp.com', 'Calle Sabor 88, Guadalajara', 'banquete', TRUE);

CREATE TABLE IF NOT EXISTS contratos (
    id_contrato INT PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(300),
    activo BOOLEAN NOT NULL DEFAULT TRUE CHECK (activo IN (0,1)),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX idx_contrato_proveedor (id_proveedor),
    INDEX idx_contrato_fechas (fecha_inicio, fecha_fin)
);

INSERT INTO contratos (id_proveedor, fecha_inicio, fecha_fin, monto, descripcion, activo) VALUES
(1,  '2025-01-01', '2025-12-31', 45000.00, 'Banquete premium para eventos corporativos y bodas', TRUE),
(2,  '2025-02-15', '2025-08-15', 12000.00, 'Suministro de bebidas y cócteles para eventos de temporada', TRUE),
(3,  '2025-03-01', '2026-03-01', 18000.00, 'Música en vivo y DJ para eventos especiales', TRUE),
(4,  '2025-04-01', '2025-10-01',  8000.00, 'Alquiler y operación de equipos de audio profesional', TRUE),
(5,  '2025-05-10', '2026-05-10', 15000.00, 'Iluminación escénica para conciertos y bodas', TRUE),
(6,  '2025-06-01', '2025-12-01',  7000.00, 'Decoración floral y arreglos para eventos', TRUE),
(7,  '2025-07-01', '2025-09-30',  5000.00, 'Ambientación temática para fiestas privadas', FALSE),
(8,  '2025-08-15', '2026-08-15',  9000.00, 'Alquiler de mobiliario para eventos empresariales', TRUE),
(9,  '2025-09-01', '2026-09-01',  6500.00, 'Servicios de fotografía y video profesional', FALSE),
(10, '2025-10-01', '2026-04-01', 11000.00, 'Banquetes gourmet para eventos sociales', TRUE);

-- creacion tabla Pagos
CREATE TABLE IF NOT EXISTS pagos(
id_pago INT PRIMARY KEY AUTO_INCREMENT,
id_evento INT NOT NULL,
fecha_pago DATETIME NOT NULL,
monto DECIMAL (10,2) NOT NULL,
metodo_pago ENUM ('efectivo', 'transferencia', 'tarjeta', 'cheque') NOT NULL,
tipo_pago ENUM ('anticipo', 'parcial', 'liquidacion') NOT NULL,
referencia VARCHAR (120),
pagado BOOLEAN NOT NULL DEFAULT TRUE CHECK (pagado IN (0,1)),
notas VARCHAR (300),

CONSTRAINT fk_pagos_evento
	FOREIGN KEY (id_evento)
    REFERENCES eventos(id_evento)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
CHECK (monto > 0),

INDEX idx_pagos_evento (id_evento),
INDEX idx_pagos_fecha (fecha_pago),
INDEX idx_pagos_tipo (tipo_pago)
);

-- consulta para saber el total real de cada evento basado en eventos_servicios
SELECT 
  e.id_evento,
  e.nombre_evento,
  SUM(es.subtotal) AS total_evento
FROM eventos e
JOIN eventos_servicios es ON es.id_evento = e.id_evento
GROUP BY e.id_evento, e.nombre_evento
ORDER BY e.id_evento;

SELECT 
  e.id_evento,
  e.nombre_evento,
  COALESCE(SUM(es.subtotal), 0) AS total_evento
FROM eventos e
LEFT JOIN eventos_servicios es 
  ON es.id_evento = e.id_evento
GROUP BY e.id_evento, e.nombre_evento
ORDER BY e.id_evento;

-- INSERTS para la tabla pagos con referencias claras

-- Evento 1: Boda García-Pérez — total 56,500 — fecha 2025-02-14
INSERT INTO pagos (id_evento, fecha_pago, monto, metodo_pago, tipo_pago, referencia, pagado, notas) VALUES
(1, '2025-01-10 12:00:00', 20000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #001', TRUE, 'Anticipo'),
(1, '2025-02-05 16:30:00', 25000.00, 'tarjeta', 'parcial', 'Pago con tarjeta VISA ****4587', TRUE, 'Parcial'),
(1, '2025-02-14 18:30:00', 11500.00, 'efectivo', 'liquidacion', 'Pago en efectivo en salón', TRUE, 'Liquidación final');

-- Evento 2: Graduación Ingeniería 2025 — total 50,800 — fecha 2025-06-20
INSERT INTO pagos VALUES
(NULL, 2, '2025-04-30 10:00:00', 20000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #002', TRUE, 'Anticipo'),
(NULL, 2, '2025-06-01 11:45:00', 20000.00, 'tarjeta', 'parcial', 'Pago con tarjeta Mastercard ****1290', TRUE, 'Parcial'),
(NULL, 2, '2025-06-20 17:00:00', 10800.00, 'efectivo', 'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 3: Cumpleaños Sofía Navarro — total 23,000 — fecha 2025-03-05
INSERT INTO pagos (id_evento, fecha_pago, monto, metodo_pago, tipo_pago, referencia, pagado, notas) VALUES
(3, '2025-02-20 10:00:00', 10000.00, 'transferencia', 'anticipo',   'Transferencia bancaria #003', TRUE, 'Anticipo'),
(3, '2025-03-05 15:00:00', 13000.00, 'efectivo',      'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 4: Evento Corporativo MPBP — total 37,800 — fecha 2025-05-10
INSERT INTO pagos VALUES
(NULL, 4, '2025-04-20 10:30:00', 15000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #003', TRUE, 'Anticipo'),
(NULL, 4, '2025-05-10 08:30:00', 22800.00, 'transferencia', 'liquidacion', 'Transferencia bancaria #004', TRUE, 'Liquidación final');

-- Evento 5: Boda Luna-Romero — total 60,000 — fecha 2025-04-18
INSERT INTO pagos VALUES
(NULL, 5, '2025-03-15 13:00:00', 30000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #005', TRUE, 'Anticipo'),
(NULL, 5, '2025-04-10 12:30:00', 15000.00, 'tarjeta', 'parcial', 'Pago con tarjeta VISA ****7643', TRUE, 'Parcial'),
(NULL, 5, '2025-04-18 16:30:00', 15000.00, 'efectivo', 'liquidacion', 'Pago en efectivo en salón', TRUE, 'Liquidación final');

-- Evento 6: Graduación Medicina 2025 — total 48,600 — fecha 2025-07-12
INSERT INTO pagos VALUES
(NULL, 6, '2025-06-20 09:20:00', 20000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #006', TRUE, 'Anticipo'),
(NULL, 6, '2025-07-05 15:40:00', 20000.00, 'tarjeta', 'parcial', 'Pago con tarjeta Mastercard ****4312', TRUE, 'Parcial'),
(NULL, 6, '2025-07-12 17:30:00', 8600.00, 'efectivo', 'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 7: Cumpleaños Jorge Torres — total 38,500 — fecha 2025-08-25
INSERT INTO pagos VALUES
(NULL, 7, '2025-08-05 10:00:00', 15000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #007', TRUE, 'Anticipo'),
(NULL, 7, '2025-08-25 12:00:00', 23500.00, 'tarjeta', 'liquidacion', 'Pago con tarjeta VISA ****8765', TRUE, 'Liquidación final');

-- Evento 8: Evento Corporativo Innovatech — total 10,300 — fecha 2025-09-15
INSERT INTO pagos VALUES
(NULL, 8, '2025-09-01 09:15:00', 5000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #008', TRUE, 'Anticipo'),
(NULL, 8, '2025-09-15 09:00:00', 5300.00, 'efectivo', 'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 9: Boda Morales-Castro — total 62,000 — fecha 2025-10-03
INSERT INTO pagos VALUES
(NULL, 9, '2025-09-10 11:00:00', 30000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #009', TRUE, 'Anticipo'),
(NULL, 9, '2025-09-25 16:00:00', 20000.00, 'tarjeta', 'parcial', 'Pago con tarjeta Mastercard ****5123', TRUE, 'Parcial'),
(NULL, 9, '2025-10-03 17:30:00', 12000.00, 'efectivo', 'liquidacion', 'Pago en efectivo en salón', TRUE, 'Liquidación final');

-- Evento 10: Graduación Derecho 2025 — total 43,200 — fecha 2025-11-28
INSERT INTO pagos VALUES
(NULL, 10, '2025-11-10 12:00:00', 20000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #010', TRUE, 'Anticipo'),
(NULL, 10, '2025-11-28 17:00:00', 23200.00, 'tarjeta', 'liquidacion', 'Pago con tarjeta VISA ****9512', TRUE, 'Liquidación final');

-- Evento 11: Cumpleaños Diego Martínez — total 18,500 — fecha 2025-12-02
INSERT INTO pagos VALUES
(NULL, 11, '2025-11-15 10:20:00', 10000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #011', TRUE, 'Anticipo'),
(NULL, 11, '2025-12-02 12:45:00', 8500.00, 'efectivo', 'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 12: Evento Corporativo TecnoGlobal — total 53,500 — fecha 2025-12-15
INSERT INTO pagos VALUES
(NULL, 12, '2025-11-30 15:30:00', 20000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #012', TRUE, 'Anticipo'),
(NULL, 12, '2025-12-10 11:15:00', 20000.00, 'tarjeta', 'parcial', 'Pago con tarjeta Mastercard ****3109', TRUE, 'Parcial'),
(NULL, 12, '2025-12-15 08:30:00', 13500.00, 'efectivo', 'liquidacion', 'Pago en efectivo en salón', TRUE, 'Liquidación final');

-- Evento 13: Boda Ríos-Domínguez — total 58,000 — fecha 2026-01-24
INSERT INTO pagos VALUES
(NULL, 13, '2025-12-20 09:00:00', 30000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #013', TRUE, 'Anticipo'),
(NULL, 13, '2026-01-10 10:00:00', 20000.00, 'tarjeta', 'parcial', 'Pago con tarjeta VISA ****7841', TRUE, 'Parcial'),
(NULL, 13, '2026-01-24 16:00:00', 8000.00, 'efectivo', 'liquidacion', 'Pago en efectivo en evento', TRUE, 'Liquidación final');

-- Evento 14: Graduación Contaduría 2026 — total 39,800 — fecha 2026-02-20
INSERT INTO pagos VALUES
(NULL, 14, '2026-01-25 14:00:00', 15000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #014', TRUE, 'Anticipo'),
(NULL, 14, '2026-02-15 12:00:00', 15000.00, 'tarjeta', 'parcial', 'Pago con tarjeta Mastercard ****6320', TRUE, 'Parcial'),
(NULL, 14, '2026-02-20 16:00:00', 9800.00, 'efectivo', 'liquidacion', 'Pago en efectivo en salón', TRUE, 'Liquidación final');

-- Evento 15: Cumpleaños Héctor Domínguez — total 20,000 — fecha 2026-03-10
INSERT INTO pagos VALUES
(NULL, 15, '2026-02-25 09:30:00', 10000.00, 'transferencia', 'anticipo', 'Transferencia bancaria #015', TRUE, 'Anticipo'),
(NULL, 15, '2026-03-10 14:00:00', 10000.00, 'tarjeta', 'liquidacion', 'Pago con tarjeta VISA ****4875', TRUE, 'Liquidación final');


-- consulta para saber el id_evento, nombre evento, total del evento, total pagado y saldo pendiente
SELECT 
  e.id_evento,
  e.nombre_evento,
  IFNULL(es.total_evento, 0) AS total_evento,
  IFNULL(p.total_pagado, 0)  AS total_pagado,
  IFNULL(es.total_evento,0) - IFNULL(p.total_pagado,0) AS saldo_pendiente
FROM eventos e
LEFT JOIN (
  SELECT id_evento, SUM(subtotal) AS total_evento
  FROM eventos_servicios
  GROUP BY id_evento
) es ON es.id_evento = e.id_evento
LEFT JOIN (
  SELECT id_evento, SUM(monto) AS total_pagado
  FROM pagos
  WHERE pagado = TRUE
  GROUP BY id_evento
) p ON p.id_evento = e.id_evento
ORDER BY e.id_evento;

