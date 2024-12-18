create database TallerPA;

use TallerPA;

CREATE TABLE cliente (
    ClienteID INT identity PRIMARY KEY,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
VALUES 
    ('Mateo', 1.72, '2001-02-20', 450.5),
    ('Maria', 1.60, '2002-05-02', 450.5),
    ('Marta', 1.48, '2001-05-25', 450.5),
    ('Marcelo', 1.80, '1999-02-17', 450.5);

CREATE PROCEDURE SeleccionarClientes
AS
BEGIN
    SELECT * FROM cliente;
END;
EXEC SeleccionarClientes;


CREATE PROCEDURE InsertarCliente
    @Nombre VARCHAR(100),
    @Estatura DECIMAL(5,2),
    @FechaNacimiento DATE,
    @Sueldo DECIMAL(10,2)
AS
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (@Nombre, @Estatura, @FechaNacimiento, @Sueldo);
END;
EXEC InsertarCliente 'Juan', 1.75, '1990-01-01', 1000.00;

ALTER TABLE cliente ADD Edad INT;
CREATE PROCEDURE ActualizarEdadCliente
    @ClienteID INT,
    @NuevaEdad INT
AS
BEGIN
    UPDATE cliente
    SET Edad = @NuevaEdad
    WHERE ClienteID = @ClienteID;
END;

EXEC ActualizarEdadCliente 1, 35;

CREATE PROCEDURE EliminarCliente
    @ClienteID INT
AS
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = @ClienteID;
END;
EXEC EliminarCliente 1;

ALTER TABLE cliente ADD CONSTRAINT UQ_ClienteID UNIQUE (ClienteID);

CREATE PROCEDURE VerificarEdadCliente
    @ClienteID INT
AS
BEGIN
    DECLARE @Edad INT;
    SELECT TOP 1 @Edad = Edad FROM cliente WHERE ClienteID = @ClienteID;
    IF @Edad >= 22
    BEGIN
        SELECT 'El cliente tiene 22 años o más.';
    END
    ELSE
    BEGIN
        SELECT 'El cliente tiene menos de 22 años.';
    END
END;

EXEC VerificarEdadCliente 1;

CREATE TABLE ordenes (
    OrdenID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    Fecha DATE,
    Monto DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);
CREATE PROCEDURE InsertarOrden
    @ClienteID INT,
    @Fecha DATE,
    @Monto DECIMAL(10,2)
AS
BEGIN
    INSERT INTO ordenes (ClienteID, Fecha, Monto)
    VALUES (@ClienteID, @Fecha, @Monto);
END;

EXEC InsertarOrden 1, '2024-12-17', 150.00;

CREATE PROCEDURE InsertarOrden
    @ClienteID INT,
    @Fecha DATE,
    @Monto DECIMAL(10,2)
AS
BEGIN
    INSERT INTO ordenes (ClienteID, Fecha, Monto)
    VALUES (@ClienteID, @Fecha, @Monto);
END;
EXEC InsertarOrden 1, '2024-12-17', 150.00;

CREATE PROCEDURE EliminarOrden
    @OrdenID INT
AS
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = @OrdenID;
END;

EXEC EliminarOrden 1;