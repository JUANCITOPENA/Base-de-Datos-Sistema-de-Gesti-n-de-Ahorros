# Base-de-Datos-Sistema-de-Gestion-de-Ahorros
Base de Datos Sistema de Gestión de Ahorros en SQL Server

![](coop.png)


## DESCRIOCION DEL MODELO:

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
