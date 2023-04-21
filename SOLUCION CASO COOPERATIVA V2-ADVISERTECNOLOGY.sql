
/*
 El modelo en estrella y el modelo en copo de nieve son dos formas de organizar los datos en 
 bases de datos relacionales y no están específicamente relacionados con cooperativas. Sin
 embargo, las cooperativas pueden utilizar bases de datos y por lo tanto, podrían optar por
 uno de estos modelos de organización de datos dependiendo de sus necesidades y requerimientos.

Por ejemplo, una cooperativa podría utilizar el modelo en estrella si desea simplificar la
estructura de sus datos y tener una tabla central de hechos que contenga información clave y
tablas de dimensiones que estén directamente relacionadas con ella. Por otro lado, una cooperativa 
que maneje una gran cantidad de datos podría optar por el modelo en copo de nieve para normalizar
sus tablas de dimensiones y reducir la redundancia de datos.

De cara al diseño, teniendo en cuenta, el diseño basado en las entidades, en los atributos y 
las propiedades, asi como las relaciones, restricciones y atomicidad como las normalizaciones 
que debemos tomar en cuanta, tengo 7 tablas, como ejemplos, Tipo Ahorros, paises, regiones,  
genero, socio o cliente, tipo de socio,  transacciones de ahorro.

 Para diseñar una base de datos que contemple las tablas mencionadas, es importante seguir un
 proceso de diseño adecuado y que tenga en cuenta la normalización de las tablas. A continuación,
 te presento un ejemplo de modelo de diseño basado en las entidades, atributos, propiedades, 
 relaciones, restricciones y normalizaciones de las 7 tablas mencionadas:

Tabla "Tipo Ahorros":

Atributos: ID_TipoAhorro, TipoAhorro, Descripcion
Propiedades: ID_TipoAhorro (clave primaria), TipoAhorro (clave única)
Restricciones: No se permiten valores nulos en TipoAhorro
Normalización: 1FN, 2FN

Tabla "Paises":

Atributos: ID_Pais, Pais
Propiedades: ID_Pais (clave primaria), Pais (clave única)
Restricciones: No se permiten valores nulos en Pais
Normalización: 1FN, 2FN

Tabla "Regiones":

Atributos: ID_Region, Region, ID_Pais
Propiedades: ID_Region (clave primaria), ID_Pais (clave foránea), Region (clave única)
Restricciones: No se permiten valores nulos en Region e ID_Pais
Normalización: 1FN, 2FN, 3FN

Tabla "Genero":

Atributos: ID_Genero, Genero
Propiedades: ID_Genero (clave primaria), Genero (clave única)
Restricciones: No se permiten valores nulos en Genero
Normalización: 1FN, 2FN

Tabla "Socio o Cliente":

Atributos: ID_Socio, Nombre, Apellido, FechaNacimiento, ID_Genero, ID_Region, ID_TipoSocio
Propiedades: ID_Socio (clave primaria), ID_Genero (clave foránea), ID_Region (clave foránea),
ID_TipoSocio (clave foránea), Nombre+Apellido (clave única)
Restricciones: No se permiten valores nulos en Nombre, Apellido, FechaNacimiento, ID_Genero,
ID_Region, ID_TipoSocio
Normalización: 1FN, 2FN, 3FN

Tabla "Tipo de Socio":

Atributos: ID_TipoSocio, TipoSocio, Descripcion
Propiedades: ID_TipoSocio (clave primaria), TipoSocio (clave única)
Restricciones: No se permiten valores nulos en TipoSocio
Normalización: 1FN, 2FN

Tabla "Transacciones de Ahorro":

Atributos: ID_Transaccion, ID_Socio, ID_TipoAhorro, Monto, FechaTransaccion
Propiedades: ID_Transaccion (clave primaria), ID_Socio (clave foránea), ID_TipoAhorro (clave foránea)
Restricciones: No se permiten valores nulos en ID_Socio, ID_TipoAhorro, Monto, FechaTransaccion
Normalización: 1FN, 2FN

Este modelo de diseño cumple con las reglas de normalización y garantiza que la información esté bien estructurada y 
sea fácilmente manejable y actualizable. Por supuesto,

*/

-- VAMOS A CREAR UNA BASE DE DATOS LLAMADA: SISTEMA DE GESTION DE AHORROS:
CREATE DATABASE SISTEMA_DE_GESTION_AHORROS;
GO

--VAMOS A USAR ESA BASE DE DATOS:
USE SISTEMA_DE_GESTION_AHORROS ;
GO


-- Crear tabla Tipo Ahorros
CREATE TABLE TipoAhorros (
ID_TipoAhorro INT PRIMARY KEY,
TipoAhorro VARCHAR(50) UNIQUE NOT NULL,
Descripcion VARCHAR(255)
);

-- Crear tabla Paises
CREATE TABLE Paises (
ID_Pais INT PRIMARY KEY,
Pais VARCHAR(50) UNIQUE NOT NULL
);

-- Crear tabla Regiones
CREATE TABLE Regiones (
ID_Region INT PRIMARY KEY,
Region VARCHAR(50) UNIQUE NOT NULL,
ID_Pais INT,
FOREIGN KEY (ID_Pais) REFERENCES Paises(ID_Pais)
);

-- Crear tabla Genero
CREATE TABLE Genero (
ID_Genero INT PRIMARY KEY,
Genero VARCHAR(10) UNIQUE NOT NULL
);

-- Crear tabla Socio o Cliente
CREATE TABLE SocioCliente (
ID_Socio INT PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
Apellido VARCHAR(50) NOT NULL,
FechaNacimiento DATE NOT NULL,
ID_Genero INT,
ID_Region INT,
ID_TipoSocio INT,
CONSTRAINT uc_SocioCliente UNIQUE (Nombre, Apellido),
FOREIGN KEY (ID_Genero) REFERENCES Genero(ID_Genero),
FOREIGN KEY (ID_Region) REFERENCES Regiones(ID_Region),
FOREIGN KEY (ID_TipoSocio) REFERENCES TipoAhorros(ID_TipoAhorro)
);

-- Crear tabla Tipo de Socio
CREATE TABLE TipoSocio (
ID_TipoSocio INT PRIMARY KEY,
TipoSocio VARCHAR(50) UNIQUE NOT NULL,
Descripcion VARCHAR(255)
);

-- Crear tabla Transacciones de Ahorro
CREATE TABLE TransaccionesAhorro (
ID_Transaccion INT PRIMARY KEY,
ID_Socio INT,
ID_TipoAhorro INT,
Monto DECIMAL(10, 2) NOT NULL,
FechaTransaccion DATE NOT NULL,
FOREIGN KEY (ID_Socio) REFERENCES SocioCliente(ID_Socio),
FOREIGN KEY (ID_TipoAhorro) REFERENCES TipoAhorros(ID_TipoAhorro)
);


-- Insertar datos en la tabla TipoAhorros
INSERT INTO TipoAhorros (ID_TipoAhorro, TipoAhorro, Descripcion)
VALUES
(1, 'Ahorro a la Vista', 'Cuenta de ahorros que permite retiros y depósitos en cualquier momento'),
(2, 'Ahorro Programado', 'Cuenta de ahorros que se programa para hacer depósitos periódicos'),
(3, 'Ahorro a Plazo', 'Cuenta de ahorros que se abre por un plazo determinado y con una tasa de interés fija');

-- Insertar datos en la tabla Paises
INSERT INTO Paises (ID_Pais, Pais)
VALUES
(1, 'República Dominicana'),
(2, 'Estados Unidos'),
(3, 'España');

-- Insertar datos en la tabla Regiones
INSERT INTO Regiones (ID_Region, Region, ID_Pais)
VALUES
(1, 'Santo Domingo', 1),
(2, 'Florida', 2),
(3, 'Madrid', 3);

-- Insertar datos en la tabla Genero
INSERT INTO Genero (ID_Genero, Genero)
VALUES
(1, 'Masculino'),
(2, 'Femenino');

-- Insertar datos en la tabla SocioCliente
INSERT INTO SocioCliente (ID_Socio, Nombre, Apellido, FechaNacimiento, ID_Genero, ID_Region, ID_TipoSocio)
VALUES
(1, 'Juan', 'Pérez', '1990-01-01', 1, 1, 1),
(2, 'María', 'García', '1985-05-12', 2, 3, 3),
(3, 'Pedro', 'Díaz', '1995-11-23', 1, 2, 2);

-- Insertar datos en la tabla TipoSocio
INSERT INTO TipoSocio (ID_TipoSocio, TipoSocio, Descripcion)
VALUES
(1, 'Socio Regular', 'Socio que realiza depósitos y retiros en cualquier momento'),
(2, 'Socio de Ahorro a Plazo', 'Socio que tiene una cuenta de ahorro a plazo'),
(3, 'Socio Programado', 'Socio que tiene una cuenta de ahorro programado');

-- Insertar datos en la tabla TransaccionesAhorro
INSERT INTO TransaccionesAhorro (ID_Transaccion, ID_Socio, ID_TipoAhorro, Monto, FechaTransaccion)
VALUES
(1, 1, 1, 5000, '2022-03-15'),
(2, 1, 3, 2000, '2022-04-01'),
(3, 2, 2, 10000, '2022-02-28'),
(4, 3, 1, 7000, '2022-05-10');


--Seleccionar todos los tipos de ahorros y sus descripciones:

SELECT TipoAhorro, Descripcion FROM TipoAhorros;

--Seleccinar los Paises:

select * from Paises

--Seleccinar los Paises:

select * from SocioCliente

--Seleccinar los Paises:

select * from TransaccionesAhorro

--Contar el número de países en la tabla de Paises:

SELECT COUNT(*) FROM Paises;

--Obtener el promedio de edad de los clientes en la tabla SocioCliente:

SELECT AVG(DATEDIFF(year, FechaNacimiento, GETDATE())) AS EdadPromedio FROM SocioCliente;

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 
       DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 
       YEAR(GETDATE()) AS Año_Actual,
       YEAR(SocioCliente.FechaNacimiento) AS Año_Nacimiento,
       YEAR(GETDATE()) - YEAR(SocioCliente.FechaNacimiento) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio;

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 
       CONVERT(varchar(4), GETDATE(), 120) AS Año_Actual,
       CONVERT(varchar(4), SocioCliente.FechaNacimiento, 120) AS Año_Nacimiento,
       CONVERT(int, CONVERT(varchar(4), GETDATE(), 120)) - CONVERT(int, CONVERT(varchar(4), SocioCliente.FechaNacimiento, 120)) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio;

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 
       CONVERT(varchar(4), GETDATE(), 120) AS Año_Actual,
       CONVERT(varchar(2), GETDATE(), 101) AS Mes_Actual,
       CONVERT(varchar(2), GETDATE(), 102) AS Dia_Actual,
       CONVERT(varchar(4), SocioCliente.FechaNacimiento, 120) AS Año_Nacimiento,
       CONVERT(varchar(2), SocioCliente.FechaNacimiento, 101) AS Mes_Nacimiento,
       CONVERT(varchar(2), SocioCliente.FechaNacimiento, 102) AS Dia_Nacimiento,
       DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio;

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 	FechaNacimiento,
       CONVERT(varchar(4), GETDATE(), 120) AS Año_Actual,
       DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio

--Consulta de datos de clientes (Nombre, Apellido, con fecha de nacimiento, fecha actual, calculo de edad y detalles de género, región y tipo de socio

SELECT SocioCliente.Nombre, SocioCliente.Apellido, 	FechaNacimiento,
FORMAT(GETDATE(), 'yyyy/MM/dd') AS Fecha_Actual,
       DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
       Genero.Genero, Regiones.Region, TipoSocio.TipoSocio
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio



--Obtener el nombre del socio y su tipo de ahorro correspondiente:

SELECT SocioCliente.Nombre, TipoAhorros.TipoAhorro
FROM SocioCliente
INNER JOIN TipoAhorros
ON SocioCliente.ID_TipoSocio = TipoAhorros.ID_TipoAhorro;

--Obtener el nombre del socio y su tipo de ahorro correspondiente y su monto:

SELECT SocioCliente.Nombre, TipoAhorros.TipoAhorro, TransaccionesAhorro.Monto
FROM SocioCliente
INNER JOIN TipoAhorros
ON SocioCliente.ID_TipoSocio = TipoAhorros.ID_TipoAhorro
INNER JOIN TransaccionesAhorro
ON SocioCliente.ID_Socio = TransaccionesAhorro.ID_Socio;


--Seleccionar el número de transacciones de ahorro por tipo de ahorro:

SELECT TipoAhorros.TipoAhorro, COUNT(*) AS TotalTransacciones
FROM TransaccionesAhorro
INNER JOIN TipoAhorros
ON TransaccionesAhorro.ID_TipoAhorro = TipoAhorros.ID_TipoAhorro
GROUP BY TipoAhorros.TipoAhorro;

--Seleccionar el número de transacciones de ahorro por tipo de ahorro  y su monto::

SELECT TipoAhorros.TipoAhorro, COUNT(*) AS TotalTransacciones, SUM(TransaccionesAhorro.Monto) AS MontoTotal
FROM TransaccionesAhorro
INNER JOIN TipoAhorros
ON TransaccionesAhorro.ID_TipoAhorro = TipoAhorros.ID_TipoAhorro
GROUP BY TipoAhorros.TipoAhorro;


--Obtener el número de socios en cada región:

SELECT Regiones.Region, COUNT(SocioCliente.ID_Socio) AS TotalSocios
FROM Regiones
LEFT JOIN SocioCliente
ON Regiones.ID_Region = SocioCliente.ID_Region
GROUP BY Regiones.Region;

--Obtener el número de socios en cada región y monto:

SELECT Regiones.Region, COUNT(SocioCliente.ID_Socio) AS TotalSocios, SUM(TransaccionesAhorro.Monto) AS MontoTotal
FROM Regiones
LEFT JOIN SocioCliente
ON Regiones.ID_Region = SocioCliente.ID_Region
LEFT JOIN TransaccionesAhorro
ON SocioCliente.ID_Socio = TransaccionesAhorro.ID_Socio
GROUP BY Regiones.Region;


--Seleccionar el socio con el ahorro más alto:

SELECT TOP 1 SocioCliente.Nombre, TipoAhorros.TipoAhorro, TransaccionesAhorro.Monto
FROM TransaccionesAhorro
INNER JOIN SocioCliente
ON TransaccionesAhorro.ID_Socio = SocioCliente.ID_Socio
INNER JOIN TipoAhorros
ON TransaccionesAhorro.ID_TipoAhorro = TipoAhorros.ID_TipoAhorro
ORDER BY TransaccionesAhorro.Monto DESC;

--Obtener el número de socios masculinos y femeninos:

SELECT Genero.Genero, COUNT(*) AS TotalSocios
FROM SocioCliente
INNER JOIN Genero
ON SocioCliente.ID_Genero = Genero.ID_Genero
GROUP BY Genero.Genero;

--Seleccionar los socios con nombre que empiezan con "J":

SELECT * FROM SocioCliente
WHERE Nombre LIKE 'J%';

--Obtener el número de transacciones de ahorro realizadas en el mes de mayo de 2022:

SELECT COUNT(*) AS TotalTransacciones FROM TransaccionesAhorro
WHERE MONTH(FechaTransaccion) = 5 AND YEAR(FechaTransaccion) = 2022;

--Seleccionar los tipos de ahorros que no han tenido transacciones:

SELECT TipoAhorro FROM TipoAhorros
LEFT JOIN TransaccionesAhorro
ON TipoAhorros.ID_TipoAhorro = TransaccionesAhorro.ID_TipoAhorro
WHERE TransaccionesAhorro.ID_Transaccion IS NULL;

--Obtener el total de ahorros realizados por cada socio en la tabla TransaccionesAhorro:

SELECT ID_Socio, SUM(Monto) AS TotalAhorros
FROM TransaccionesAhorro
GROUP BY ID_Socio;

--Obtener el total de ahorros realizados por cada socio en la tabla TransaccionesAhorro:

SELECT TransaccionesAhorro.ID_Socio,SocioCliente.Nombre,  SUM(TransaccionesAhorro.Monto) AS TotalAhorros
FROM TransaccionesAhorro
INNER JOIN SocioCliente
ON TransaccionesAhorro.ID_Socio = SocioCliente.ID_Socio
GROUP BY TransaccionesAhorro.ID_Socio, SocioCliente.Nombre;


--Seleccionar los socios que tienen más de 30 años y tienen una cuenta de ahorro a plazo:

SELECT SocioCliente.Nombre, SocioCliente.Apellido
FROM SocioCliente
INNER JOIN TipoAhorros
ON SocioCliente.ID_TipoSocio = TipoAhorros.ID_TipoAhorro
WHERE DATEDIFF(year, FechaNacimiento, GETDATE()) > 30 AND TipoAhorros.TipoAhorro = 'Ahorro a Plazo';

--Seleccionar los socios que tienen más de 30 años y tienen una cuenta de ahorro a plazo y monto:

SELECT SocioCliente.Nombre, SocioCliente.Apellido, TransaccionesAhorro.Monto
FROM SocioCliente
INNER JOIN TipoAhorros
ON SocioCliente.ID_TipoSocio = TipoAhorros.ID_TipoAhorro
INNER JOIN TransaccionesAhorro
ON SocioCliente.ID_Socio = TransaccionesAhorro.ID_Socio
WHERE DATEDIFF(year, FechaNacimiento, GETDATE()) > 30 AND TipoAhorros.TipoAhorro = 'Ahorro a Plazo';


--Obtener la fecha de la primera transacción de ahorro de cada socio:

SELECT ID_Socio, MIN(FechaTransaccion) AS FechaPrimeraTransaccion
FROM TransaccionesAhorro
GROUP BY ID_Socio;


---- Insertar datos en la tabla TipoAhorros
INSERT INTO TipoAhorros (ID_TipoAhorro, TipoAhorro, Descripcion)
VALUES
(4, 'Ahorro a la Infancia', 'Cuenta de ahorro destinada para menores de edad'),
(5, 'Ahorro para la Educación', 'Cuenta de ahorro destinada para cubrir gastos educativos'),
(6, 'Ahorro para la Jubilación', 'Cuenta de ahorro para prepararse para la jubilación');

-- Insertar datos en la tabla Paises
INSERT INTO Paises (ID_Pais, Pais)
VALUES
(4, 'México'),
(5, 'Colombia'),
(6, 'Perú');

-- Insertar datos en la tabla Regiones
INSERT INTO Regiones (ID_Region, Region, ID_Pais)
VALUES
(4, 'Guadalajara', 4),
(5, 'Antioquia', 5),
(6, 'Lima', 6);

-- Insertar datos en la tabla Genero
INSERT INTO Genero (ID_Genero, Genero)
VALUES
(3, 'Otro'),
(4, 'No Binario');

-- Insertar datos en la tabla SocioCliente
INSERT INTO SocioCliente (ID_Socio, Nombre, Apellido, FechaNacimiento, ID_Genero, ID_Region, ID_TipoSocio)
VALUES
(4, 'Ana', 'Ramírez', '2000-02-20', 2, 4, 2),
(5, 'Miguel', 'Hernández', '1980-10-05', 1, 5, 1),
(6, 'Paola', 'Gómez', '1998-06-15', 2, 6, 3);

-- Insertar datos en la tabla TipoSocio
INSERT INTO TipoSocio (ID_TipoSocio, TipoSocio, Descripcion)
VALUES
(4, 'Socio de Ahorro a la Infancia', 'Socio que tiene una cuenta de ahorro a la infancia'),
(5, 'Socio de Ahorro para la Educación', 'Socio que tiene una cuenta de ahorro para la educación'),
(6, 'Socio de Ahorro para la Jubilación', 'Socio que tiene una cuenta de ahorro para la jubilación');

-- Insertar datos en la tabla TransaccionesAhorro
INSERT INTO TransaccionesAhorro (ID_Transaccion, ID_Socio, ID_TipoAhorro, Monto, FechaTransaccion)
VALUES
(5, 4, 2, 15000, '2022-03-01'),
(6, 4, 4, 5000, '2022-06-30'),
(7, 5, 1, 10000, '2022-05-01'),
(8, 6, 5, 2000, '2022-04-15'),
(9, 6, 6, 25000, '2022-01-01');



-- VAMOS A CREAR UNA CONSULTA PARA MOSTRAR TODOS LOS DATOS DE LAS TABLAS EN UNA SOLA:
SELECT 
    SocioCliente.Nombre, 
    SocioCliente.Apellido, 
    FORMAT(SocioCliente.FechaNacimiento, 'dd/MM/yyyy') AS FechaNacimiento,
    DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
    Genero.Genero, 
    Regiones.Region, 
    TipoSocio.TipoSocio, 
    TipoAhorros.TipoAhorro,
    TransaccionesAhorro.Monto,
    FORMAT(TransaccionesAhorro.FechaTransaccion, 'dd/MM/yyyy') AS FechaTransaccion
FROM SocioCliente
INNER JOIN Genero
    ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
    ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
    ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio
INNER JOIN TransaccionesAhorro
    ON SocioCliente.ID_Socio = TransaccionesAhorro.ID_Socio
INNER JOIN TipoAhorros
    ON TransaccionesAhorro.ID_TipoAhorro = TipoAhorros.ID_TipoAhorro;

--CREATE VIEW vista_socios QUE MUESTRE TODO:
CREATE VIEW vista_socios AS
SELECT 
    SocioCliente.Nombre, 
    SocioCliente.Apellido, 
    FORMAT(SocioCliente.FechaNacimiento, 'dd/MM/yyyy') AS FechaNacimiento,
    DATEDIFF(year, SocioCliente.FechaNacimiento, GETDATE()) AS Edad,
    Genero.Genero, 
    Regiones.Region, 
    TipoSocio.TipoSocio, 
    TipoAhorros.TipoAhorro,
    TransaccionesAhorro.Monto,
    FORMAT(TransaccionesAhorro.FechaTransaccion, 'dd/MM/yyyy') AS FechaTransaccion
FROM SocioCliente
INNER JOIN Genero
    ON SocioCliente.ID_Genero = Genero.ID_Genero
INNER JOIN Regiones
    ON SocioCliente.ID_Region = Regiones.ID_Region
INNER JOIN TipoSocio
    ON SocioCliente.ID_TipoSocio = TipoSocio.ID_TipoSocio
INNER JOIN TransaccionesAhorro
    ON SocioCliente.ID_Socio = TransaccionesAhorro.ID_Socio
INNER JOIN TipoAhorros
    ON TransaccionesAhorro.ID_TipoAhorro = TipoAhorros.ID_TipoAhorro;

--AHORA SELECIONEMOS LA VISTA
select * from vista_socios

