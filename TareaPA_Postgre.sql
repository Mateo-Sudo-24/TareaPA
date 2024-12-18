-- Database: TareaPA

-- DROP DATABASE IF EXISTS "TareaPA";

CREATE DATABASE "TareaPA"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE cliente (
    ClienteID INT PRIMARY KEY,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);

CREATE OR REPLACE FUNCTION InsertarCliente(
    Nombre VARCHAR(100),
    Estatura DECIMAL(5,2),
    FechaNacimiento DATE,
    Sueldo DECIMAL(10,2)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (Nombre, Estatura, FechaNacimiento, Sueldo);
END;
$$ LANGUAGE plpgsql;
CREATE SEQUENCE cliente_clienteid_seq;



INSERT INTO cliente (ClienteID,Nombre, Estatura, FechaNacimiento, Sueldo)
VALUES 
    (1,'Mateo', 1.72, '2001-02-20', 450.5),
    (2,'Maria', 1.60, '2002-05-02', 450.5),
    (3,'Marta', 1.48, '2001-05-25', 450.5),
    (4,'Marcelo', 1.80, '1999-02-17', 450.5);

CREATE OR REPLACE FUNCTION SeleccionarClientes()
RETURNS TABLE (
    clienteid INT,
    Nombre VARCHAR(100),
    Estatura DECIMAL(5,2),
    FechaNacimiento DATE,
    Sueldo DECIMAL(10,2)
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM cliente;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM SeleccionarClientes();

ALTER TABLE cliente ADD COLUMN Edad INT;

CREATE OR REPLACE FUNCTION InsertarCliente(
    ClienteID INT,
    Nombre VARCHAR(100),
    Estatura DECIMAL(5,2),
    FechaNacimiento DATE,
    Sueldo DECIMAL(10,2),
    Edad INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo, Edad)
    VALUES (Nombre, Estatura, FechaNacimiento, Sueldo, Edad);
END;
$$ LANGUAGE plpgsql;

SELECT InsertarCliente(5,'Juan', 1.75, '1990-01-01', 1000.00, 34);

CREATE OR REPLACE FUNCTION ActualizarEdadCliente(
    ClienteID INT,
    NuevaEdad INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE cliente
    SET Edad = NuevaEdad
    WHERE clienteid = ClienteID;
END;
$$ LANGUAGE plpgsql;
SELECT ActualizarEdadCliente(1, 35);

CREATE OR REPLACE FUNCTION EliminarCliente(
    ClienteID INT
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM cliente
    WHERE clienteid = ClienteID;
END;
$$ LANGUAGE plpgsql;
SELECT EliminarCliente(1);

CREATE OR REPLACE FUNCTION VerificarEdadCliente(
    ClienteID INT
)
RETURNS TEXT AS $$
DECLARE
    Edad INT;
BEGIN
    SELECT Edad INTO Edad FROM cliente WHERE clienteid = ClienteID LIMIT 1;
    IF Edad >= 22 THEN
        RETURN 'El cliente tiene 22 años o más.';
    ELSE
        RETURN 'El cliente tiene menos de 22 años.';
    END IF;
END;
$$ LANGUAGE plpgsql;
SELECT VerificarEdadCliente(1);


-- creacion tabla ordenes

CREATE TABLE ordenes (
    OrdenID SERIAL PRIMARY KEY,
    ClienteID INT,
    Fecha DATE,
    Monto DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

-- inserccion de orden
CREATE OR REPLACE FUNCTION InsertarOrden(
    ClienteID INT,
    Fecha DATE,
    Monto DECIMAL(10,2)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO ordenes (ClienteID, Fecha, Monto)
    VALUES (ClienteID, Fecha, Monto);
END;
$$ LANGUAGE plpgsql;
SELECT InsertarOrden(1, '2024-12-17', 150.00);
-- procedimiento de actualizacion de orden
CREATE OR REPLACE FUNCTION ActualizarOrden(
    OrdenID INT,
    NuevoMonto DECIMAL(10,2)
)
RETURNS VOID AS $$
BEGIN
    UPDATE ordenes
    SET Monto = NuevoMonto
    WHERE OrdenID = OrdenID;
END;
$$ LANGUAGE plpgsql;
SELECT ActualizarOrden(1, 200.00);
-- eliminacion de orden
CREATE OR REPLACE FUNCTION EliminarOrden(
    OrdenID INT
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = OrdenID;
END;
$$ LANGUAGE plpgsql;
SELECT EliminarOrden(1);