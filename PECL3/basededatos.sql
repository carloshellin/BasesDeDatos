-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: supermercado | type: DATABASE --
-- -- DROP DATABASE IF EXISTS supermercado;
-- CREATE DATABASE supermercado;
-- -- ddl-end --
-- 

-- object: public.tienda | type: TABLE --
-- DROP TABLE IF EXISTS public.tienda CASCADE;
CREATE TABLE public.tienda(
	codigo serial NOT NULL,
	ciudad varchar(100) NOT NULL,
	CONSTRAINT "Tienda_pk" PRIMARY KEY (codigo)

);
-- ddl-end --
ALTER TABLE public.tienda OWNER TO postgres;
-- ddl-end --

-- object: public.opinion | type: TABLE --
-- DROP TABLE IF EXISTS public.opinion CASCADE;
CREATE TABLE public.opinion(
	fechahora timestamp NOT NULL,
	texto varchar(500),
	puntuacion smallint,
	codigo_tienda integer NOT NULL,
	telefono_socio varchar(20) NOT NULL,
	CONSTRAINT opinion_pk PRIMARY KEY (fechahora,telefono_socio),
	CONSTRAINT chk_puntuacion CHECK (puntuacion >= 0 and puntuacion <= 10)

);
-- ddl-end --
ALTER TABLE public.opinion OWNER TO postgres;
-- ddl-end --

-- object: public.oferta | type: TABLE --
-- DROP TABLE IF EXISTS public.oferta CASCADE;
CREATE TABLE public.oferta(
	fechainicio timestamp NOT NULL,
	descuento float NOT NULL,
	codigobarras_producto integer NOT NULL,
	CONSTRAINT oferta_pk PRIMARY KEY (fechainicio),
	CONSTRAINT chk_descuento CHECK (descuento >= 0 and descuento <= 1)

);
-- ddl-end --
ALTER TABLE public.oferta OWNER TO postgres;
-- ddl-end --

-- object: public.iva | type: TABLE --
-- DROP TABLE IF EXISTS public.iva CASCADE;
CREATE TABLE public.iva(
	porcentaje float NOT NULL,
	tipo char(1),
	CONSTRAINT iva_pk PRIMARY KEY (porcentaje)

);
-- ddl-end --
ALTER TABLE public.iva OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto(
	codigobarras serial NOT NULL,
	nombre varchar(150) NOT NULL,
	preciosiniva money NOT NULL,
	stock integer NOT NULL,
	porcentaje_iva float,
	CONSTRAINT "Producto_pk" PRIMARY KEY (codigobarras)

);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.cupon CASCADE;
CREATE TABLE public.cupon(
	codigo serial NOT NULL,
	telefono_socio varchar(20),
	CONSTRAINT "Cupon_pk" PRIMARY KEY (codigo)

);
-- ddl-end --
ALTER TABLE public.cupon OWNER TO postgres;
-- ddl-end --

-- object: public.descuento | type: TABLE --
-- DROP TABLE IF EXISTS public.descuento CASCADE;
CREATE TABLE public.descuento(
	cantidad float NOT NULL,
	codigo_cupon integer NOT NULL,
	codigobarras_producto integer NOT NULL,
	CONSTRAINT descuento_pk PRIMARY KEY (codigo_cupon,codigobarras_producto),
	CONSTRAINT chk_cantidad CHECK (cantidad >= 0 and cantidad <= 1)

);
-- ddl-end --
ALTER TABLE public.descuento OWNER TO postgres;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT tienda_fk FOREIGN KEY (codigo_tienda)
REFERENCES public.tienda (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.ticket | type: TABLE --
-- DROP TABLE IF EXISTS public.ticket CASCADE;
CREATE TABLE public.ticket(
	fechahoraemision timestamp NOT NULL,
	total money NOT NULL,
	telefonomovil_trabajador varchar(20) NOT NULL,
	telefono_socio varchar(20),
	CONSTRAINT ticket_pk PRIMARY KEY (fechahoraemision,telefonomovil_trabajador)

);
-- ddl-end --
ALTER TABLE public.ticket OWNER TO postgres;
-- ddl-end --

-- object: public.clasificacion | type: TABLE --
-- DROP TABLE IF EXISTS public.clasificacion CASCADE;
CREATE TABLE public.clasificacion(
	fecha date NOT NULL,
	nota smallint NOT NULL,
	telefonomovil_trabajador1 varchar(20) NOT NULL,
	telefonomovil_trabajador varchar(20) NOT NULL,
	CONSTRAINT chk_nota CHECK (nota >= 0 and nota <= 10),
	CONSTRAINT clasificacion_pk PRIMARY KEY (fecha,telefonomovil_trabajador1)

);
-- ddl-end --
ALTER TABLE public.clasificacion OWNER TO postgres;
-- ddl-end --

-- object: cupon_fk | type: CONSTRAINT --
-- ALTER TABLE public.descuento DROP CONSTRAINT IF EXISTS cupon_fk CASCADE;
ALTER TABLE public.descuento ADD CONSTRAINT cupon_fk FOREIGN KEY (codigo_cupon)
REFERENCES public.cupon (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.descuento DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.descuento ADD CONSTRAINT producto_fk FOREIGN KEY (codigobarras_producto)
REFERENCES public.producto (codigobarras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.oferta DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.oferta ADD CONSTRAINT producto_fk FOREIGN KEY (codigobarras_producto)
REFERENCES public.producto (codigobarras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador CASCADE;
CREATE TABLE public.trabajador(
	telefonomovil varchar(20) NOT NULL,
	telefonofijo varchar(20),
	nombre varchar(100) NOT NULL,
	apellidos varchar(100) NOT NULL,
	turno char(1) NOT NULL,
	horas smallint NOT NULL,
	codigo_tienda integer,
	CONSTRAINT trabajador_pk PRIMARY KEY (telefonomovil)

);
-- ddl-end --
ALTER TABLE public.trabajador OWNER TO postgres;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.clasificacion DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.clasificacion ADD CONSTRAINT trabajador_fk FOREIGN KEY (telefonomovil_trabajador)
REFERENCES public.trabajador (telefonomovil) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.trabajador ADD CONSTRAINT tienda_fk FOREIGN KEY (codigo_tienda)
REFERENCES public.tienda (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.socio | type: TABLE --
-- DROP TABLE IF EXISTS public.socio CASCADE;
CREATE TABLE public.socio(
	telefono varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	nombre varchar(100) NOT NULL,
	apellidos varchar(100) NOT NULL,
	calle varchar(50) NOT NULL,
	portal integer NOT NULL,
	piso smallint,
	letra varchar(1),
	CONSTRAINT socio_pk PRIMARY KEY (telefono)

);
-- ddl-end --
ALTER TABLE public.socio OWNER TO postgres;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT socio_fk FOREIGN KEY (telefono_socio)
REFERENCES public.socio (telefono) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.cupon DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.cupon ADD CONSTRAINT socio_fk FOREIGN KEY (telefono_socio)
REFERENCES public.socio (telefono) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT socio_fk FOREIGN KEY (telefono_socio)
REFERENCES public.socio (telefono) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: iva_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto DROP CONSTRAINT IF EXISTS iva_fk CASCADE;
ALTER TABLE public.producto ADD CONSTRAINT iva_fk FOREIGN KEY (porcentaje_iva)
REFERENCES public.iva (porcentaje) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.articulo | type: TABLE --
-- DROP TABLE IF EXISTS public.articulo CASCADE;
CREATE TABLE public.articulo(
	codigobarras_producto integer NOT NULL,
	fechahoraemision_ticket timestamp NOT NULL,
	telefonomovil_trabajador_ticket varchar(20) NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT articulo_pk PRIMARY KEY (codigobarras_producto,fechahoraemision_ticket,telefonomovil_trabajador_ticket)

);
-- ddl-end --
ALTER TABLE public.articulo OWNER TO postgres;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.articulo DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.articulo ADD CONSTRAINT producto_fk FOREIGN KEY (codigobarras_producto)
REFERENCES public.producto (codigobarras) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT trabajador_fk FOREIGN KEY (telefonomovil_trabajador)
REFERENCES public.trabajador (telefonomovil) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.articulo DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.articulo ADD CONSTRAINT ticket_fk FOREIGN KEY (fechahoraemision_ticket,telefonomovil_trabajador_ticket)
REFERENCES public.ticket (fechahoraemision,telefonomovil_trabajador) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.clasificacion DROP CONSTRAINT IF EXISTS trabajador_fk1 CASCADE;
ALTER TABLE public.clasificacion ADD CONSTRAINT trabajador_fk1 FOREIGN KEY (telefonomovil_trabajador1)
REFERENCES public.trabajador (telefonomovil) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


