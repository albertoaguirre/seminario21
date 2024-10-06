/*ALUMNO: ALBERTO BASILIO AGUIRRE
DNI: 32329678
VINF012826*/ 


/*CREACION DE LA BASE DE DATOS Y TABLAS:*/


CREATE DATABASE misionesenergia_gestion;
USE misionesenergia_gestion;

-- Tabla Clientes
CREATE TABLE Clientes (
    idclientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(255),
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Tabla Contratos
CREATE TABLE Contratos (
    idcontratros INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    detalles TEXT,
    fecha_contrato DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);

-- Tabla Productos
CREATE TABLE Productos (
    idproductos INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    marca VARCHAR(255),
    modelo VARCHAR(255)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    idventas INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_venta DATE DEFAULT CURRENT_DATE,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes)
);

-- Tabla DetalleVentas
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

-- Tabla Facturas
CREATE TABLE Facturas (
    idfacturas INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT,
    fecha_factura DATE DEFAULT CURRENT_DATE,
    monto_total DECIMAL(10, 2),
    FOREIGN KEY (venta_id) REFERENCES Ventas(idventas)
);

-- Tabla Pagos
CREATE TABLE Pagos (
    idpagos INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    venta_id INT,
    fecha_pago DATE DEFAULT CURRENT_DATE,
    monto DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(idclientes),
    FOREIGN KEY (venta_id) REFERENCES Ventas(idventas)
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



-- Tabla Proyectos
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
