CREATE SCHEMA IF NOT EXISTS almacen
    AUTHORIZATION admin_palmarisa;

CREATE TABLE IF NOT EXISTS almacen.categorias (
        id SERIAL PRIMARY KEY,
        categoria VARCHAR(50),
);

CREATE TABLE IF NOT EXISTS almacen.destinos_especificos (
        id SERIAL PRIMARY KEY,
        destino_especifico VARCHAR(50),
);
--'equipo','lote','edificacion','empleados','of.BGA','of.SanPablo'

CREATE TABLE IF NOT EXISTS almacen.productos (
        id SERIAL PRIMARY KEY,
        nombre_producto VARCHAR(50),
        unidades VARCHAR(50), 
        id_categoria INT REFERENCES almacen.categorias(id),
        minimo FLOAT
);

CREATE TABLE IF NOT EXISTS almacen.productos_precios (
        id SERIAL PRIMARY KEY,
        id_producto INT REFERENCES almacen.productos(id),
        precio FLOAT
);

CREATE TABLE IF NOT EXISTS almacen.inventario (
        ultima_fecha_de_ingreso TIMESTAMP,
        id_producto INT REFERENCES almacen.productos_precios(id),
        cantidad FLOAT,

);

CREATE TABLE IF NOT EXISTS almacen.transacciones_salida(
        fecha_hora TIMESTAMP,
        id_producto INT REFERENCES almacen.inventario(id_producto),
        cantidad FLOAT,
        centro_costos INT REFERENCES almacen.centro_costos(id),
        destino_especifico INT REFERENCES almacen.destinos_especificos(id),
        observaciones VARCHAR,
        user_id INT,
        PRIMARY KEY(fecha,id_producto)
);

CREATE TABLE IF NOT EXISTS almacen.transacciones_entrada(
        fecha_hora TIMESTAMP,
        id_producto INT REFERENCES almacen.productos_precios(id),
        cantidad FLOAT,
        numero_factura VARCHAR,
        proveedor VARCHAR,
        user_id INT,
        PRIMARY KEY(fecha,id_producto)
);

CREATE SCHEMA IF NOT EXISTS usuarios
        AUTHORIZATION admin_palmarisa;

CREATE TABLE IF NOT EXISTS usuarios.tabla_usuarios(
        id SERIAL PRIMARY KEY,
        username VARCHAR UNIQUE,
        nombre VARCHAR,
        apellido VARCHAR,
        fecha_creado TIMESTAMP DEFAULT CURRENT_DATE,
        fecha_modificado TIMESTAMP DEFAULT CURRENT_DATE
);
CREATE UNIQUE INDEX idx_username ON usuarios.tabla_usuarios(username);