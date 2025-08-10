📘 Ejercicios de SQL - MySQL
Índice de Ejercicios
Unión de Tablas (JOIN)
Tipos de Datos en SQL
Uso de LIKE y Comodines
Expresiones Regulares
Subconsultas en SQL
Combinación de Subconsultas y Funciones
Data Definition Language (DDL)
Sentencias de Manipulación de Objetos
Funciones Escalares
Ejercicios de Unión de Tablas (JOIN)
Obtener los nombres y apellidos de los alumnos junto con el nombre del curso en el que están inscritos.

SELECT a.nombre, a.apellido, c.nombre_curso
FROM alumnos a
INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
INNER JOIN cursos c ON i.id_curso = c.id_curso;
Listar los alumnos que no están inscritos en ningún curso.

SELECT a.nombre, a.apellido
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
WHERE i.id_inscripcion IS NULL;
Obtener el número total de alumnos por curso.

SELECT c.nombre_curso, COUNT(i.id_alumno) AS cantidad_alumnos
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.nombre_curso;
Ejercicios de Tipos de Datos
Agregar un nuevo campo promedio_final de tipo DECIMAL(5,2) a la tabla alumnos.

ALTER TABLE alumnos ADD COLUMN promedio_final DECIMAL(5,2);
Modificar el campo telefono para que acepte solo números enteros de hasta 15 dígitos.

ALTER TABLE alumnos MODIFY COLUMN telefono BIGINT(15);
Insertar un nuevo alumno y verificar que los tipos de datos se respeten.

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, edad)
VALUES ('Lucas', 'González', 'lucas@mail.com', 22334455, 1133344556, 22);
Ejercicios de LIKE y Comodines
Encontrar todos los alumnos cuyo nombre comienza con "M".

SELECT * FROM alumnos WHERE nombre LIKE 'M%';
Obtener los alumnos cuyo email contiene "gmail".

SELECT * FROM alumnos WHERE email LIKE '%gmail%';
Buscar los alumnos cuyo apellido termine con "z".

SELECT * FROM alumnos WHERE apellido LIKE '%z';
Listar los alumnos cuyo teléfono empieza con "11".

SELECT * FROM alumnos WHERE telefono LIKE '11%';
Ejercicios de Expresiones Regulares
Obtener los alumnos con un email válido que termine en .com o .net.

SELECT * FROM alumnos WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(com|net)$';
Buscar los alumnos cuyos nombres tengan solo letras mayúsculas.

SELECT * FROM alumnos WHERE nombre REGEXP '^[A-Z]+$';
Filtrar alumnos con un DNI de exactamente 8 dígitos.

SELECT * FROM alumnos WHERE dni REGEXP '^[0-9]{8}$';
Ejercicios de Subconsultas en SQL
Obtener el alumno más joven.

SELECT * FROM alumnos WHERE edad = (SELECT MIN(edad) FROM alumnos);
Encontrar los alumnos mayores de edad inscritos en algún curso.

SELECT * FROM alumnos WHERE edad >= 18 AND id_alumno IN (SELECT id_alumno FROM inscripciones);
Contar cuántos alumnos tienen más de 25 años.

SELECT COUNT(*) FROM alumnos WHERE edad > 25;
Ejercicios de Combinación de Subconsultas y Funciones
Obtener la edad promedio de los alumnos inscritos en cursos.

SELECT AVG(edad) FROM alumnos WHERE id_alumno IN (SELECT id_alumno FROM inscripciones);
Determinar cuántos alumnos argentinos hay en la base de datos.

SELECT COUNT(*) FROM alumnos WHERE nacionalidad = 'Argentina';
Encontrar la edad mínima y máxima por nacionalidad.

SELECT nacionalidad, MIN(edad) AS menor_edad, MAX(edad) AS mayor_edad
FROM alumnos GROUP BY nacionalidad;
Ejercicios de Data Definition Language (DDL)
Crear una tabla profesores con las siguientes columnas:

id_profesor (INT, clave primaria, autoincremental)
nombre (VARCHAR(50))
apellido (VARCHAR(50))
email (VARCHAR(100), único)
CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
Eliminar la tabla profesores si existe.

DROP TABLE IF EXISTS profesores;
Ejercicios de Manipulación de Objetos
Vaciar completamente la tabla alumnos sin eliminar su estructura.

TRUNCATE TABLE alumnos;
Eliminar todos los alumnos menores de 18 años.

DELETE FROM alumnos WHERE edad < 18;
Ejercicios de Funciones Escalares
Concatenar nombre y apellido en una sola columna llamada nombre_completo.

SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM alumnos;
Convertir todos los nombres a mayúsculas.

SELECT UCASE(nombre) FROM alumnos;
Obtener la fecha actual.

SELECT NOW();
Obtener la suma total de edades de los alumnos.

SELECT SUM(edad) FROM alumnos;
Redondear el promedio de edades a 2 decimales.

SELECT ROUND(AVG(edad), 2) FROM alumnos;
🚀 ¡A practicar y mejorar tus habilidades en SQL!

🧑‍🏫 Profesor
👨‍💻 Alejandro Daniel Di Stefano
📌 Desarrollador Full Stack
🔗 GitHub: Drako01