/*ALUMNO: ALBERTO BASILIO AGUIRRE
DNI: 32329678
VINF012826*/ 


/* BASE DE DATOS Y CREACION DE TABLAS EN MYSQL:
Creación de las tablas. 
Inserción, consulta y borrado de registros.
Presentación de las consultas SQL.
*/


/*CREACION DE LA BASE DE DATOS*/

CREATE DATABASE misionesenergia_gestion;
USE misionesenergia_gestion;


/*CREACION DE LAS TABLAS:*/

CREATE TABLE Clientes (
    idclientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(255),
    fecha_registro DATE DEFAULT CURRENT_DATE
);


/*CREACION TABLA CONTRATOS:*/
CREATE TABLE Contratos (
    idcontratros INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    detalles TEXT,
    fecha_contrato DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);



/*CREACION TABLA PRODUCTOS:*/

CREATE TABLE Productos (
    idproductos INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    marca VARCHAR(255),
    modelo VARCHAR(255)
);
 
/*CREACION TABLA VENTAS:*/


CREATE TABLE Ventas (
    idventas INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_venta DATE DEFAULT CURRENT_DATE,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);
 


/*CREACION TABLA DEETALLE DE VENTAS:*/

CREATE TABLE DetalleVentas (
    iddetalleventas INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) AS (cantidad * precio_unitario),
    FOREIGN KEY (venta_id) REFERENCES Ventas(idventas),
    FOREIGN KEY (producto_id) REFERENCES Productos(idproductos)
);


/*CREACION TABLA FACTURAS:*/

CREATE TABLE Facturas (
    idfacturas INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT,
    fecha_factura DATE DEFAULT CURRENT_DATE,
    monto_total DECIMAL(10, 2),
    FOREIGN KEY (venta_id) REFERENCES Ventas(idventas)
);


/*CREACION TABLA PAGOS:*/
CREATE TABLE Pagos (
    idpagos INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    venta_id INT,
    fecha_pago DATE DEFAULT CURRENT_DATE,
    monto DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes),
    FOREIGN KEY (venta_id) REFERENCES Ventas(idventas)
);


/*CREACION TABLA PROYECTOS: */

CREATE TABLE Proyectos (
    idproyectos INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    nombre_proyecto VARCHAR(255),
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);

/*CREACION DE ORDENES DE TRABAJO:*/

CREATE TABLE OrdenesDeTrabajo (
    idordendetrabajo INT AUTO_INCREMENT PRIMARY KEY,
    proyecto_id INT,
    instalador_id INT,
    fecha_orden DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(50),
    FOREIGN KEY (proyecto_id) REFERENCES Proyectos(idproyectos)
);


/*CREACION DE TABLA INSTALADORES: */

CREATE TABLE Instaladores (
    idinstaladores INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    num_matricula INT(20) NOT NULL 
);


/*CREACION DE TABLA PROVEEDORES: */

CREATE TABLE Proveedores (
    idproveedores INT AUTO_INCREMENT PRIMARY KEY,
    cuit INT(10) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    contacto VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL
);


/*CREACION TABLA COMPRAS: */

CREATE TABLE Compras (
    idcompras INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT,
    fecha_compra DATE DEFAULT CURRENT_DATE,
    total_compra DECIMAL(10, 2),
    descripcion VARCHAR(255),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(idproveedores)
);


/*CREACION TABLA DETALLE COMPRAS*/


CREATE TABLE DetalleCompras (
    iddetallecompras INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    subtotal DECIMAL(10, 2) AS (cantidad * precio_unitario),
    descripcion VARCHAR (255) NOT NULL, 
    FOREIGN KEY (compra_id) REFERENCES Compras(idcompras),
    FOREIGN KEY (producto_id) REFERENCES Productos(idproductos)
);


/*CREACION TABLA MONITOREO DE EQUIPOS*/

CREATE TABLE MonitoreoEquipos (
    idmonitoreoequipos INT AUTO_INCREMENT PRIMARY KEY,
    equipo_id INT,
    fecha_monitoreo DATE DEFAULT CURRENT_DATE,
    energia_generada DECIMAL(10, 2),
    estado VARCHAR(50),
    FOREIGN KEY (equipo_id) REFERENCES Productos(idproductos)
);

/*CREACION TABLA SERVICIOSPOSTVENTA*/

CREATE TABLE ServiciosPostVenta (
    idserviciospostventa INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_servicio DATE DEFAULT CURRENT_DATE,
    descripcion TEXT,
    estado VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);



/* INSERCION CONSULTA, Y BORRADO DE REGISTROS:*/

/*INSERCION DE REGISTROS EN LA TABLA CLIENTES: */

-- Clientes
INSERT INTO Clientes (nombre, direccion, telefono, email) 
VALUES 
('Juan Pérez', 'Av. Libertador 1234', '3412345678', 'juanperez@gmail.com'),
('María López', 'Calle Falsa 456', '3512345678', 'marialopez@hotmail.com'),
('Carlos González', 'Av. San Martín 789', '3812345678', 'carlosg@hotmail.com'),
('Ana García', 'Ruta 12 Km 100', '3415671234', 'anagarcia@hotmail.com'),
('Pedro Fernández', 'Calle Córdoba 1500', '2612349876', 'pedrofernandez@hotmail.com'),
('Laura Sánchez', 'Boulevard Oroño 2500', '3417896543', 'laurasanchez@hotmail.com'),
('Luis Ramírez', 'Pasaje Colon 123', '3515554321', 'luisramirez@gmail.com'),
('Patricia Mendoza', 'Av. Corrientes 850', '3819876543', 'patriciamendoza@outlook.com'),
('Diego Castro', 'Calle Entre Ríos 678', '3418881234', 'diegocastro@gmail.com'),
('Sofía Herrera', 'Ruta 9 Km 20', '3517779876', 'sofiaher@outlook.com'),
('Jorge Vega', 'Calle San Juan 543', '3816549876', 'jorgevega@outlook.com'),
('Valeria Morales', 'Av. Belgrano 123', '3415556667', 'valeriamorales@electroradio.com'),
('Alberto Ríos', 'Calle Mendoza 789', '3516549876', 'albertorios@hormisa.com'),
('Rosa Torres', 'Ruta Nacional 40', '3817896543', 'rosatorres@cocacola.com.ar'),
('Manuel Díaz', 'Av. Colón 2500', '3419876543', 'manueldiaz@outlook.com');



/*INSERCION DE REGISTROS EN LA TABLA PRODUCTOS:*/

-- Paneles solares
INSERT INTO Productos (nombre, descripcion, precio, stock, marca, modelo) 
VALUES 
('Panel Solar 300W', 'Panel solar de 300W para instalaciones residenciales', 15000.00, 50, 'SolarBrand', 'SB300'),
('Panel Solar 250W', 'Panel solar de 250W para instalaciones medianas', 12000.00, 100, 'EcoPower', 'EP250'),
('Panel Solar 400W', 'Panel solar de 400W para instalaciones industriales', 20000.00, 30, 'SunTech', 'ST400'),
('Panel Solar 500W', 'Panel solar de 500W con alta eficiencia', 25000.00, 40, 'GreenSun', 'GS500'),
('Kit Solar 3kW', 'Kit solar de 3kW para viviendas', 60000.00, 20, 'SolarKit', 'SK3KW'),
('Panel Solar 350W', 'Panel solar de 350W para pequeñas instalaciones', 17000.00, 60, 'RenewTech', 'RT350'),
('Inversor Solar 5kW', 'Inversor solar de 5kW para generación distribuida', 40000.00, 10, 'PowerInverter', 'PI5KW'),
('Panel Solar 600W', 'Panel solar de 600W con tecnología avanzada', 30000.00, 25, 'SolarMax', 'SM600'),
('Panel Solar Bifacial 400W', 'Panel solar bifacial para mayor eficiencia', 22000.00, 15, 'DualEnergy', 'DE400'),
('Microinversor 1kW', 'Microinversor de 1kW para sistemas pequeños', 10000.00, 70, 'MiniInverter', 'MI1KW');



/*INSERCION DE REGISTROS EN LA TABLA CONTRATOS: */
-- Inserciones para la tabla Contratos
INSERT INTO Contratos (cliente_id, detalles, fecha_contrato)
VALUES 
(1, 'Contrato de instalación de sistema fotovoltaico residencial de 3kW', '2023-01-15'),
(2, 'Contrato de mantenimiento preventivo anual para sistema solar comercial', '2023-02-10'),
(3, 'Contrato de instalación de paneles solares para planta industrial de 50kW', '2023-03-05'),
(4, 'Contrato de ampliación de sistema fotovoltaico residencial de 5kW', '2023-04-01'),
(5, 'Contrato de revisión técnica y optimización de sistema de energía solar', '2023-05-12'),
(6, 'Contrato de implementación de proyecto de generación distribuida 10kW', '2023-06-20'),
(7, 'Contrato de instalación de sistema solar híbrido con baterías', '2023-07-15'),
(8, 'Contrato de instalación de sistema solar fotovoltaico de 8kW en escuela rural', '2023-08-02'),
(9, 'Contrato de suministro e instalación de paneles solares para comunidad rural', '2023-09-18'),
(10, 'Contrato de mantenimiento y supervisión de sistema fotovoltaico empresarial', '2023-10-10'),
(11, 'Contrato de instalación de sistema fotovoltaico de 15kW en edificio comercial', '2023-11-03'),
(12, 'Contrato de instalación de sistema solar para generación distribuida de 20kW', '2023-12-01'),
(13, 'Contrato de reparación de inversores en sistema solar residencial', '2024-01-09'),
(14, 'Contrato de ampliación de sistema solar para fábrica industrial', '2024-02-16'),
(15, 'Contrato de instalación de paneles solares en centro deportivo de 30kW', '2024-03-12');

/*INSERCION DE REGISTROS TABLA PROVEEDORES:*/
-- Proveedores
INSERT INTO Proveedores (cuit, nombre, contacto, telefono, email, direccion) 
VALUES 
(20451234567, 'Energía Solar SRL', 'Laura Pérez', '3412345678', 'lperez@energiasolar.com', 'Av. Rivadavia 4321'),
(20345678901, 'Tecnología Verde SA', 'José García', '3512349876', 'jgarcia@tecverde.com', 'Calle San Martín 987'),
(20341234567, 'EcoPower Ltda', 'Ana Rodríguez', '3812345678', 'arodriguez@ecopower.com', 'Calle Corrientes 1234'),
(20459876543, 'Soluciones Energéticas SRL', 'Carlos Torres', '3415671234', 'ctorres@solenergeticas.com', 'Boulevard Belgrano 2500'),
(20452345678, 'Distribuciones Solares SA', 'María Gómez', '2612345678', 'mgomez@distsolares.com', 'Av. Libertador 987'),
(20543216789, 'Paneles y Energía SA', 'Patricia Ramírez', '3417896543', 'pramirez@panelsolar.com', 'Ruta Nacional 40'),
(20456789012, 'Energías Renovables SA', 'Juan Fernández', '3515554321', 'jfernandez@renovables.com', 'Calle Mendoza 5678'),
(20348976543, 'Instalaciones Verdes SRL', 'Pedro Martínez', '3819876543', 'pmartinez@instalverde.com', 'Calle San Juan 123'),
(20451238976, 'Generación Solar Ltda', 'Sofía Torres', '3418881234', 'storres@gensolar.com', 'Calle Córdoba 678'),
(20345671234, 'EcoInnovación SA', 'Diego Herrera', '3517779876', 'dherrera@ecoinnovacion.com', 'Ruta Nacional 9'),
(20459872345, 'Energía Limpia SRL', 'Patricia Díaz', '3816549876', 'pdiaz@energialimpia.com', 'Calle Entre Ríos 890'),
(20341239876, 'Paneles del Futuro SA', 'Marcelo Quiroga', '3415556667', 'mquiroga@panelfuturo.com', 'Calle San Luis 123'),
(20452349876, 'Energías del Sol Ltda', 'Valeria Mendoza', '3516549876', 'vmendoza@energiassol.com', 'Av. Belgrano 456'),
(20543219876, 'Soluciones Verdes SRL', 'Manuel Díaz', '3817896543', 'mdiaz@solucverdes.com', 'Calle Tucumán 789'),
(20459872349, 'Paneles y Equipos SRL', 'Alberto Ríos', '3419876543', 'arios@panelsolar.com', 'Calle Belgrano 2500');



/*INSERCION DE DATOS TABLA INSTALADORES*/ 
-- Instaladores
INSERT INTO Instaladores (nombre, telefono, email, direccion, num_matricula) 
VALUES 
('Juan Martínez', '3412345678', 'juanmartinez@hotmail.com', 'Av. Colón 1234', 987654),
('Carla Gómez', '3512349876', 'carlagomez@outlook.com', 'Calle San Juan 5678', 876543),
('Roberto Silva', '3812345678', 'robertosilva@ingenieriaarsat.com', 'Av. Rivadavia 4321', 765432),
('María Torres', '3415671234', 'mariatorres@matiatorres.com', 'Calle Independencia 321', 654321),
('Luis Fernández', '2612345678', 'luisfernandez@outlook.com', 'Av. Libertad 987', 543210),
('Ana Ramírez', '3417896543', 'anaramirez@instalaciones.com', 'Boulevard Belgrano 123', 432109),
('Pedro Castillo', '3515554321', 'pedrocastillo@gmail.com', 'Ruta 9 Km 20', 321098),
('Patricia López', '3819876543', 'patricialopez@outlook.com', 'Av. San Martín 2500', 210987),
('Diego Herrera', '3418881234', 'diegoherrera@instalaciones.com', 'Calle Corrientes 123', 109876),
('Sofía Sánchez', '3517779876', 'sofiasanchez@outlook.com', 'Ruta Nacional 40', 987123),
('Marcelo Quiroga', '3816549876', 'marceloquiroga@gmail.com', 'Calle Córdoba 5678', 876321),
('Lucía Díaz', '3415556667', 'luciadiaz@gmail.com', 'Calle Mendoza 4321', 765210),
('Federico Vega', '3516549876', 'federicovega@gmail.com', 'Calle Belgrano 6789', 654109),
('Valeria Montalvo', '3817896543', 'valeriamontalvo@gmail.com', 'Calle Tucumán 9876', 543098),
('Alberto Sánchez', '3419876543', 'albertosanchez@hotmail.com', 'Calle San Luis 5678', 432987);


/*INSERCION DE DATOS EN TABLA SERVICIO POSTVENTA:*/

-- Servicios PostVenta
INSERT INTO ServiciosPostVenta (cliente_id, descripcion, estado) 
VALUES 
(1, 'Revisión anual de sistema fotovoltaico de 3kW', 'Completado'),
(2, 'Cambio de inversor en sistema residencial', 'Pendiente'),
(3, 'Limpieza y mantenimiento de paneles solares', 'Completado'),
(4, 'Diagnóstico de fallas en sistema industrial', 'En Progreso'),
(5, 'Reemplazo de microinversores', 'Pendiente'),
(6, 'Optimización de sistema fotovoltaico para mejor rendimiento', 'Completado'),
(7, 'Revisión de cableado de instalación comercial', 'En Progreso'),
(8, 'Cambio de batería en sistema de almacenamiento', 'Completado'),
(9, 'Reparación de panel dañado en sistema rural', 'Completado'),
(10, 'Mantenimiento preventivo de sistema industrial', 'Pendiente'),
(11, 'Inspección técnica de sistema solar para generación distribuida', 'Completado'),
(12, 'Diagnóstico de cortocircuito en sistema fotovoltaico', 'Pendiente'),
(13, 'Sustitución de paneles solares por modelos más eficientes', 'En Progreso'),
(14, 'Revisión de inversor en sistema residencial', 'Completado'),
(15, 'Mantenimiento general del sistema en fábrica industrial', 'Completado');




-- Contratos asociados a los clientes
INSERT INTO Contratos (cliente_id, detalles) 
VALUES 
(1, 'Contrato de instalación de sistema solar de 3kW'),
(2, 'Contrato para sistema fotovoltaico residencial de 5kW'),
(3, 'Contrato para suministro y montaje de paneles solares de 10kW'),
(4, 'Contrato de energía solar para instalación comercial de 20kW'),
(5, 'Contrato de instalación para finca agrícola'),
(6, 'Contrato para generación distribuida urbana 5kW'),
(7, 'Contrato de paneles solares para instalación industrial de 50kW'),
(8, 'Contrato para generación distribuida rural'),
(9, 'Contrato de instalación de paneles solares en hospital'),
(10, 'Contrato de proyecto solar con almacenamiento de energía'),
(11, 'Contrato de instalación de paneles solares en escuela pública'),
(12, 'Contrato de instalación fotovoltaica para residencia privada'),
(13, 'Contrato para proyecto solar comercial'),
(14, 'Contrato de instalación de sistemas solares en comunidad rural'),
(15, 'Contrato de proyecto de generación distribuida en fábrica industrial');

/*INSERCION EN LA TABLA PRODUCTOS:*/
-- Paneles solares
INSERT INTO Productos (nombre, descripcion, precio, stock, marca, modelo) 
VALUES 
('Panel Solar 300W', 'Panel solar de 300W para instalaciones residenciales', 15000.00, 50, 'SolarBrand', 'SB300'),
('Panel Solar 250W', 'Panel solar de 250W para instalaciones medianas', 12000.00, 100, 'EcoPower', 'EP250'),
('Panel Solar 400W', 'Panel solar de 400W para instalaciones industriales', 20000.00, 30, 'SunTech', 'ST400'),
('Panel Solar 500W', 'Panel solar de 500W con alta eficiencia', 25000.00, 40, 'GreenSun', 'GS500'),
('Kit Solar 3kW', 'Kit solar de 3kW para viviendas', 60000.00, 20, 'SolarKit', 'SK3KW'),
('Panel Solar 350W', 'Panel solar de 350W para pequeñas instalaciones', 17000.00, 60, 'RenewTech', 'RT350'),
('Inversor Solar 5kW', 'Inversor solar de 5kW para generación distribuida', 40000.00, 10, 'PowerInverter', 'PI5KW'),
('Panel Solar 600W', 'Panel solar de 600W con tecnología avanzada', 30000.00, 25, 'SolarMax', 'SM600'),
('Panel Solar Bifacial 400W', 'Panel solar bifacial para mayor eficiencia', 22000.00, 15, 'DualEnergy', 'DE400'),
('Microinversor 1kW', 'Microinversor de 1kW para sistemas pequeños', 10000.00, 70, 'MiniInverter', 'MI1KW');


/*INSERCION EN LA TABLA PROYECTOS:*/
-- Proyectos fotovoltaicos y de generación distribuida
INSERT INTO Proyectos (cliente_id, nombre_proyecto, descripcion, fecha_inicio, fecha_fin, estado) 
VALUES 
(1, 'Proyecto Solar Residencial', 'Instalación de paneles solares en una residencia de 3kW', '2024-01-01', '2024-01-15', 'Completado'),
(2, 'Proyecto Solar Comercial', 'Generación distribuida en un negocio comercial de 10kW', '2024-02-01', '2024-02-20', 'En progreso'),
(3, 'Proyecto Fotovoltaico Industrial', 'Instalación fotovoltaica en una fábrica de 50kW', '2024-03-10', '2024-04-05', 'Pendiente'),
(4, 'Proyecto Solar Escolar', 'Generación de energía renovable en una escuela pública', '2024-04-10', '2024-04-30', 'Completado'),
(5, 'Proyecto Solar Agrícola', 'Suministro de energía solar para una finca agrícola', '2024-05-01', '2024-05-20', 'En progreso'),
(6, 'Proyecto Generación Distribuida Urbana', 'Generación distribuida en un edificio urbano de 5kW', '2024-06-05', '2024-06-20', 'Pendiente'),
(7, 'Proyecto Solar Comercial Grande', 'Proyecto solar de 20kW para una tienda departamental', '2024-07-01', '2024-07-25', 'En progreso'),
(8, 'Proyecto Generación Distribuida Rural', 'Generación distribuida para una comunidad rural', '2024-08-01', '2024-08-20', 'Pendiente'),
(9, 'Proyecto Solar para Hospital', 'Suministro de energía renovable para un hospital', '2024-09-01', '2024-09-20', 'Completado'),
(10, 'Proyecto Solar de Almacenamiento', 'Proyecto solar con almacenamiento para energía nocturna', '2024-10-01', '2024-10-30', 'En progreso');


/*INSERCION EN LA TABLA ORDENES DE TRABAJO*/
-- Ordenes de trabajo asociadas a los proyectos
INSERT INTO OrdenesDeTrabajo (proyecto_id, instalador_id, estado) 
VALUES 
(1, 1, 'Finalizado'),
(2, 2, 'En curso'),
(3, 3, 'Pendiente'),
(4, 4, 'Finalizado'),
(5, 5, 'En curso'),
(6, 6, 'Pendiente'),



/*INSERCION EN LA TABLA MONITOREO EQUIPOS:*/
-- Monitoreo de equipos
INSERT INTO MonitoreoEquipos (equipo_id, energia_generada, estado) 
VALUES 
(1, 500.50, 'Operativo'),
(2, 600.75, 'Operativo'),
(3, 300.30, 'Mantenimiento'),
(4, 800.80, 'Operativo'),
(5, 900.00, 'Reparación'),
(6, 750.25, 'Operativo'),
(7, 400.50, 'Mantenimiento'),
(8, 650.60, 'Operativo'),
(9, 1000.00, 'Operativo'),
(10, 550.45, 'Operativo'),
(11, 480.00, 'Operativo'),
(12, 320.30, 'Reparación'),
(13, 870.60, 'Mantenimiento'),
(14, 980.90, 'Operativo'),
(15, 620.15, 'Operativo');


/*INSERCION DE DATOS EN TABLA VENTAS*/
-- tabla Ventas
INSERT INTO Ventas (cliente_id, fecha_venta, total) VALUES
(1, '2024-01-15', 15000.00),
(2, '2024-01-20', 20000.00),
(3, '2024-02-05', 25000.00),
(4, '2024-02-10', 18000.00),
(5, '2024-02-15', 22000.00),
(6, '2024-03-01', 30000.00),
(7, '2024-03-10', 27000.00),
(8, '2024-03-15', 19000.00),
(9, '2024-04-01', 16000.00),
(10, '2024-04-10', 30000.00),
(11, '2024-04-20', 24000.00),
(12, '2024-05-01', 35000.00),
(13, '2024-05-10', 27000.00),
(14, '2024-05-20', 18000.00),
(15, '2024-06-01', 22000.00);


/*INSERCION DE DATOS EN TABLA DETALLE VENTAS:*/
-- Detalle de ventas asociadas a los productos
INSERT INTO DetalleVentas (venta_id, producto_id, cantidad, precio_unitario) 
VALUES 
(1, 1, 10, 15000.00), 
(2, 2, 5, 12000.00),  
(3, 3, 10, 20000.00),
(4, 4, 4, 25000.00),  
(5, 5, 3, 60000.00), 
(6, 6, 6, 17000.00), 
(7, 7, 2, 40000.00), 
(8, 8, 5, 30000.00), 
(9, 9, 10, 22000.00), 
(10, 10, 10, 10000.00),
(11, 1, 5, 15000.00),
(12, 2, 8, 12000.00),
(13, 3, 5, 20000.00),
(14, 4, 6, 25000.00),
(15, 5, 4, 60000.00);


/*INSERCION DE DATOS EN LA TABLA FACTURAS:*/

-- Facturas asociadas a las ventas
INSERT INTO Facturas (venta_id, monto_total) 
VALUES 
(1, 45000.00),
(2, 60000.00),
(3, 125000.00),
(4, 85000.00),
(5, 70000.00),
(6, 90000.00),
(7, 250000.00),
(8, 120000.00),
(9, 140000.00),
(10, 180000.00),
(11, 100000.00),
(12, 55000.00),
(13, 175000.00),
(14, 110000.00),
(15, 220000.00);


/* INSERCION DE DATOS EN LA TABLA PAGOS: */
-- Pagos realizados por los clientes
INSERT INTO Pagos (cliente_id, venta_id, monto) 
VALUES 
(1, 1, 45000.00),
(2, 2, 60000.00),
(3, 3, 125000.00),
(4, 4, 85000.00),
(5, 5, 70000.00),
(6, 6, 90000.00),
(7, 7, 250000.00),
(8, 8, 120000.00),
(9, 9, 140000.00),
(10, 10, 180000.00),
(11, 11, 100000.00),
(12, 12, 55000.00),
(13, 13, 175000.00),
(14, 14, 110000.00),
(15, 15, 220000.00);
(7, 1, 'En curso'),
(8, 2, 'Pendiente'),
(9, 3, 'Finalizado'),
(10, 4, 'En curso');



/*CONSULTAS DE REGISTROS:*/

-- CONSULTA DE CLIENTES: 
SELECT * FROM Clientes;

-- CONSULTA DE CONTRATOS POR CLIENTES:
SELECT * FROM Contratos WHERE cliente_id = 1;


-- CONSULTA DE VENTAS Y SUS TOTALES: 
SELECT v.idventas, c.nombre, v.fecha_venta, v.total FROM Ventas v
JOIN Clientes c ON v.cliente_id = c.idclientes;


-- CONSULTA DE DETALLES DE VENTAS POR VENTA:

SELECT dv.*, p.nombre FROM DetalleVentas dv
JOIN Productos p ON dv.producto_id = p.idproductos
WHERE dv.venta_id = 1;


-- CONSULTA DE FACTURAS: 
SELECT * FROM Facturas;



/*BORRADO DE REGISTROS*/

-- BORRADO DE UN CLIENTE: 
DELETE FROM Clientes WHERE idclientes = 5;

-- BORRADO DE UN CONTRATO: 
DELETE FROM Contratos WHERE idcontratros = 3;

-- BORRADO DE UNA VENTA: 
DELETE FROM Ventas WHERE idventas = 2;


-- BORRADO DE UN DETALLE DE VENTA: 
DELETE FROM DetalleVentas WHERE iddetalleventas = 1;


-- BORRADO DE UNA FACTURA: 

DELETE FROM Facturas WHERE idfacturas = 4;

-- BORRADO DE UN PAGO: 
DELETE FROM Pagos WHERE idpagos = 3;







