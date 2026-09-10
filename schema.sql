-- Food Store - esquema base para el laboratorio TP2
-- PostgreSQL

DROP TABLE IF EXISTS pedido_detalle CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TYPE IF EXISTS forma_pago;

CREATE TYPE forma_pago AS ENUM ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA');

CREATE TABLE categoria (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE cliente (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE producto (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    categoria_id BIGINT NOT NULL REFERENCES categoria(id) ON DELETE RESTRICT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(12,2) NOT NULL CHECK (precio >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE pedido (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id BIGINT NOT NULL REFERENCES cliente(id) ON DELETE RESTRICT,
    fecha TIMESTAMPTZ NOT NULL DEFAULT now(),
    forma_pago forma_pago NOT NULL
);

-- En este esquema base, tres reglas quedan deliberadamente para
-- restricciones_integridad.sql y así poder documentar el ejercicio de la Parte 1:
-- 1) cantidad > 0
-- 2) precio_unitario >= 0
-- 3) no repetir un producto dentro del mismo pedido
CREATE TABLE pedido_detalle (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id BIGINT NOT NULL REFERENCES pedido(id) ON DELETE RESTRICT,
    producto_id BIGINT NOT NULL REFERENCES producto(id) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(12,2) NOT NULL
);

-- Buscar pedidos de un cliente.
CREATE INDEX idx_pedido_cliente_id ON pedido(cliente_id);

-- Listar productos por categoría y estado.
CREATE INDEX idx_producto_categoria_activo
    ON producto(categoria_id, activo);
