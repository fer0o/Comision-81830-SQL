CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;
CREATE TABLE IF NOT EXISTS alumnos(
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

ALTER TABLE alumnos ADD COLUMN fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE alumnos ADD COLUMN instituto VARCHAR(120);
ALTER TABLE alumnos ADD COLUMN edad INT UNSIGNED DEFAULT NULL;
ALTER TABLE alumnos MODIFY COLUMN instituto VARCHAR(60) DEFAULT 'CoderHouse';

SELECT * FROM alumnos;
INSERT INTO alumnos(nombre, apellido, dni) VALUES ("Alejandro", "Di Stefano", 22333555);
INSERT INTO alumnos(nombre, apellido, email, dni, edad) VALUES ("Diego", "Fernandez", "diego@mail.com", 23565656, 25);

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Sabrina", "Gonzalez", "sabri@mail.com", 33556565, 23, "11555666");

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Soledad", "Pastoruti", "lasole@mail.com", 40565655, 35, "1156666"),
("Enrique", "Octavo", "henry@mail.com", 6521212, 22, "2265656");

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("German", "Legresti", "german@mail.com", 23455987, 35, "12345663"),
("Soledad", "Ferreyra", NULL, 326655655, 41, NULL),
("Hernan", "Garcia", "asdadasd@mail.com", 23555656, 30, "16521212");


UPDATE alumnos SET edad = 49 WHERE id_alumno = 1;

UPDATE alumnos SET email = "diegoreyes@mail.com", telefono = "22651656", apellido = "Reyes" WHERE id_alumno = 3;

UPDATE alumnos SET nacionalidad = "Uruguaya" WHERE  id_alumno > 6;
DELETE FROM alumnos WHERE id_alumno = 5;
DELETE FROM alumnos WHERE edad > 35;

-- Uso de Alias
SELECT COUNT(*) AS alumnos_uruguayos FROM alumnos WHERE nacionalidad = "Uruguaya";
SELECT COUNT(*) AS alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT SUM(edad) AS suma_total_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";
SELECT AVG(edad) AS promedio_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT
		COUNT(edad) AS cantidad_alumnos,
        SUM(edad) AS suma_edades,
        AVG(edad) AS promedio_edades
FROM alumnos 
	WHERE nacionalidad = "Argentina";
    
    
SELECT nombre, apellido, edad 
FROM alumnos
WHERE edad >= 18
ORDER BY edad DESC;

-- Consultar Mas Joven y el Mayor
SELECT
	MIN(edad) AS Joven,
    MAX(edad) AS Mayor
FROM alumnos;

SELECT nombre, apellido, email, edad, telefono, nacionalidad
FROM alumnos
ORDER BY nacionalidad ASC
LIMIT 10;



SELECT nacionalidad,
COUNT(*) AS Grupo_Nacionalidad
FROM alumnos
GROUP BY nacionalidad;


CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;
CREATE TABLE IF NOT EXISTS alumnos(
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

ALTER TABLE alumnos ADD COLUMN fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE alumnos ADD COLUMN instituto VARCHAR(120);
ALTER TABLE alumnos ADD COLUMN edad INT UNSIGNED DEFAULT NULL;
ALTER TABLE alumnos MODIFY COLUMN instituto VARCHAR(60) DEFAULT 'CoderHouse';

SELECT * FROM alumnos;
INSERT INTO alumnos(nombre, apellido, dni) VALUES ("Alejandro", "Di Stefano", 22333555);
INSERT INTO alumnos(nombre, apellido, email, dni, edad) VALUES ("Diego", "Fernandez", "diego@mail.com", 23565656, 25);

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Sabrina", "Gonzalez", "sabri@mail.com", 33556565, 23, "11555666");

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Soledad", "Pastoruti", "lasole@mail.com", 40565655, 35, "1156666"),
("Enrique", "Octavo", "henry@mail.com", 6521212, 22, "2265656");

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("German", "Legresti", "german@mail.com", 23455987, 35, "12345663"),
("Soledad", "Ferreyra", NULL, 326655655, 41, NULL),
("Hernan", "Garcia", "asdadasd@mail.com", 23555656, 30, "16521212");


UPDATE alumnos SET edad = 49 WHERE id_alumno = 1;

UPDATE alumnos SET email = "diegoreyes@mail.com", telefono = "22651656", apellido = "Reyes" WHERE id_alumno = 3;

UPDATE alumnos SET nacionalidad = "Uruguaya" WHERE  id_alumno > 6;
DELETE FROM alumnos WHERE id_alumno = 5;
DELETE FROM alumnos WHERE edad > 35;

-- Uso de Alias
SELECT COUNT(*) AS alumnos_uruguayos FROM alumnos WHERE nacionalidad = "Uruguaya";
SELECT COUNT(*) AS alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT SUM(edad) AS suma_total_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";
SELECT AVG(edad) AS promedio_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT
		COUNT(edad) AS cantidad_alumnos,
        SUM(edad) AS suma_edades,
        AVG(edad) AS promedio_edades
FROM alumnos 
	WHERE nacionalidad = "Argentina";
    
    
SELECT nombre, apellido, edad 
FROM alumnos
WHERE edad >= 18
ORDER BY edad DESC;

-- Consultar Mas Joven y el Mayor
SELECT
	MIN(edad) AS Joven,
    MAX(edad) AS Mayor
FROM alumnos;

SELECT nombre, apellido, email, edad, telefono, nacionalidad
FROM alumnos
ORDER BY nacionalidad ASC
LIMIT 10;



SELECT nacionalidad,
COUNT(*) AS Grupo_Nacionalidad
FROM alumnos
GROUP BY nacionalidad;

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
VALUES ('Carlos', 'López', 'carlos.lopez@gmail.com', 37845612, '1122334455', 'Chile');

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
VALUES 
('Lucía', 'Méndez', 'lucia.mendez@mail.com', 51234567, '1133445566', 'México'),
('Andrés', 'Ibarra', 'andres.ibarra@mail.com', 52345678, '1144556677', 'Perú');

-- Especificando NULL:
INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
VALUES ('Saul', 'Goodman', 'saulg@gmail.com', 378456132, NULL, 'México');

INSERT INTO alumnos (nombre, apellido, dni, nacionalidad)
VALUES ('Roberto', 'Lewan', 37845622, 'Polonia');

UPDATE alumnos
SET telefono = '112255'
WHERE id_alumno = 16;

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
VALUES ('Maria', 'Del Barrio', 'mbarrio@mail.com', 542342343, '234234234', 'Bolivia');

UPDATE alumnos
SET dni = dni + 1
WHERE nacionalidad = 'Argentina';

select * from alumnos;
SELECT id_alumno, nombre, apellido FROM alumnos;


CREATE TABLE pedidos (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
producto VARCHAR(100) NOT NULL,
id_alumno INT,
FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno)
);
select * from pedidos;

INSERT INTO pedidos (producto, id_alumno) VALUES
('Curso SQL', 1),
('Curso React', 2),
('Curso Python', 3),
('Curso JavaScript', 4),
('Curso Node.js', 10),
('Curso MySQL', 11),
('Curso HTML', 15),
('Curso CSS', 18);
INSERT INTO pedidos (producto, id_alumno) VALUES
('Curso de Python', 1),
('Curso de SQL Avanzado', 1),
('Curso de HTML y CSS', 1);

ALTER TABLE alumnos ADD COLUMN fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP;


DESCRIBE alumnos;

SELECT alumnos.nombre, pedidos.producto
FROM alumnos
INNER JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;

SELECT alumnos.nombre, pedidos.producto
FROM alumnos
LEFT JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;

SELECT alumnos.nombre, alumnos.apellido
FROM alumnos
LEFT JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno
WHERE pedidos.id_alumno IS NULL;



SELECT alumnos.nombre, alumnos.apellido, COUNT(pedidos.id_pedido) AS cantidad_pedidos
FROM alumnos
LEFT JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno
GROUP BY alumnos.id_alumno, alumnos.nombre, alumnos.apellido;

CREATE TABLE profesores (
  id_profesor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(80) NOT NULL,
  email VARCHAR(150) UNIQUE,
  dni INT UNIQUE NOT NULL
);
INSERT INTO profesores (nombre, apellido, email, dni) VALUES
('Lucía', 'Méndez', 'lucia.mendez@mail.com', 51234567),
('Carlos', 'López', 'carlos.lopez@gmail.com', 37845612),
('Diego', 'Reyes', 'diegoreyes@mail.com', 23565656),
('Roberto', 'Lewan', 'roberto.lewan@mail.com', 30000000);

select * from profesores;

SELECT nombre, apellido, email FROM alumnos
UNION
SELECT nombre, apellido, email FROM profesores;

SELECT nombre, apellido, email, 'Alumno' AS tipo FROM alumnos
UNION
SELECT nombre, apellido, email, 'Profesor' AS tipo FROM profesores;

SELECT nombre, apellido, email, 'Alumno' AS tipo FROM alumnos
UNION
SELECT nombre, apellido, email, 'Profesor' AS tipo FROM profesores;