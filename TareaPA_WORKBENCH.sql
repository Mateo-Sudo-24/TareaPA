create database TareaPA;
use TareaPA;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  -- Campo para el ID único del cliente
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
DELIMITER $$  
CREATE PROCEDURE InsertarCliente(  
    IN Nombre VARCHAR(100),  
    IN Estatura DECIMAL(5,2),  
    IN FechaNacimiento DATE,  
    IN Sueldo DECIMAL(10,2)  
)  
BEGIN  
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)  
    VALUES (Nombre, Estatura, FechaNacimiento, Sueldo); 
END $$  
DELIMITER ;  

DELIMITER $$  
CREATE PROCEDURE SeleccionarClientes()  
BEGIN  
    SELECT * FROM cliente;  
END $$  
DELIMITER ;  
CALL SeleccionarClientes();  

DELIMITER $$  
CREATE PROCEDURE ActualizarSueldo(  
    IN ClienteID INT,  
    IN NuevoSueldo DECIMAL(10,2)  
)  
BEGIN  
    UPDATE cliente  
    SET Sueldo = NuevoSueldo  
    WHERE ClienteID = ClienteID;  
END $$  
DELIMITER ; 
 
DELIMITER $$  
CREATE PROCEDURE ActualizarSueldo(  
    IN ClienteID INT,  
    IN NuevoSueldo DECIMAL(10,2)  
)  
BEGIN  
    UPDATE cliente  
    SET Sueldo = NuevoSueldo  
    WHERE ClienteID = ClienteID;  
END $$  
DELIMITER ;  
CALL ActualizarSueldo(1, 1500.00);
-- Crear cliente
DELIMITER $$  
CREATE PROCEDURE InsertarCliente(  
    IN Nombre VARCHAR(100),  
    IN Estatura DECIMAL(5,2),  
    IN FechaNacimiento DATE,  
    IN Sueldo DECIMAL(10,2)  
)  
BEGIN  
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)  
    VALUES (Nombre, Estatura, FechaNacimiento, Sueldo);  
END $$  
DELIMITER ;
CALL InsertarCliente('Juan', 1.75, '1990-01-01', 1000.00);
-- Actualizar edad cliente especifico
DELIMITER $$  
CREATE PROCEDURE ActualizarEdadCliente(  
    IN ClienteID INT,  
    IN NuevaEdad INT  
)  
BEGIN  
    UPDATE cliente  
    SET Edad = NuevaEdad  
    WHERE ClienteID = ClienteID;  
END $$  
DELIMITER ;  
CALL ActualizarEdadCliente(1, 35);
ALTER TABLE cliente ADD Edad INT;

-- Eliminar cliente  
DELIMITER $$  
CREATE PROCEDURE EliminarCliente(  
    IN ClienteID INT  
)  
BEGIN  
    DELETE FROM cliente  
    WHERE ClienteID = ClienteID;  
END $$  
DELIMITER ;  
CALL EliminarCliente(1);
-- Condicional IF
ALTER TABLE cliente ADD CONSTRAINT UNIQUE (ClienteID); -- Declara unico al ID
DELIMITER $$  
CREATE PROCEDURE VerificarEdadCliente(  
    IN ClienteID INT  
)  
BEGIN  
    DECLARE Edad INT;  
    SELECT Edad INTO Edad FROM cliente WHERE ClienteID = ClienteID LIMIT 1;  
    IF Edad >= 22 THEN  
        SELECT 'El cliente tiene 22 años o más.';  
    ELSE  
        SELECT 'El cliente tiene menos de 22 años.';  
    END IF;  
END $$  
DELIMITER ;  
CALL VerificarEdadCliente(1);

-- CREACION TABLA ORDENES
CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    Fecha DATE,
    Monto DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);
-- procedemineto de orden
DELIMITER $$  
CREATE PROCEDURE InsertarOrden(  
    IN ClienteID INT,  
    IN Fecha DATE,  
    IN Monto DECIMAL(10,2)  
)  
BEGIN  
    INSERT INTO ordenes (ClienteID, Fecha, Monto)  
    VALUES (ClienteID, Fecha, Monto);  
END $$  
DELIMITER ;  
CALL InsertarOrden(1, '2024-12-17', 150.00);
-- Actualizacion de orden
DELIMITER $$  
CREATE PROCEDURE ActualizarOrden(  
    IN OrdenID INT,  
    IN NuevoMonto DECIMAL(10,2)  
)  
BEGIN  
    UPDATE ordenes  
    SET Monto = NuevoMonto  
    WHERE OrdenID = OrdenID;  
END $$  
DELIMITER ;  
CALL ActualizarOrden(1, 200.00);
-- Eliminacion de orden
DELIMITER $$  
CREATE PROCEDURE EliminarOrden(  
    IN OrdenID INT  
)  
BEGIN  
    DELETE FROM ordenes  
    WHERE OrdenID = OrdenID;  
END $$  
DELIMITER ;  
CALL EliminarOrden(1);