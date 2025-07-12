CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;
CREATE TABLE IF NOT EXISTS alumnos(
id INT PRIMARY KEY 	AUTO_INCREMENT NOT NULL,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
dni VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) UNIQUE,
nacionalidad VARCHAR (30) DEFAULT "Argentina"
);

INSERT INTO alumnos(nombre, apellido, dni, email, nacionalidad)
VALUES("Fernando", "Medellin", "27362736", "fernandomedellin@gmail.com", "Mexico");

SELECT * FROM alumnos;
-- comentarios
-- DROP TABLE persona;
 DROP TABLE alumnos;