-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1-beta
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.com.br
-- Model Author: ---


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: supermercado | type: DATABASE --
-- -- DROP DATABASE IF EXISTS supermercado;
-- CREATE DATABASE supermercado
-- ;
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
	codigo serial NOT NULL,
	texto varchar(500),
	fechahora timestamp,
	puntuacion smallint,
	codigo_tienda integer NOT NULL,
	numero_socio integer NOT NULL,
	CONSTRAINT "Opinion_pk" PRIMARY KEY (codigo),
	CONSTRAINT puntuacion_chk CHECK (puntuacion > 0 and puntuacion <= 10)

);
-- ddl-end --
ALTER TABLE public.opinion OWNER TO postgres;
-- ddl-end --

-- object: public.socio | type: TABLE --
-- DROP TABLE IF EXISTS public.socio CASCADE;
CREATE TABLE public.socio(
	numero serial NOT NULL,
	email varchar(50),
	nombre varchar(150),
	direccion varchar(100),
	telefono varchar(20),
	CONSTRAINT "Socio_pk" PRIMARY KEY (numero)

);
-- ddl-end --
ALTER TABLE public.socio OWNER TO postgres;
-- ddl-end --

-- object: public.trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador CASCADE;
CREATE TABLE public.trabajador(
	codigo serial NOT NULL,
	nombre varchar(150),
	telefonofijo varchar(20),
	telefonomovil varchar(20),
	turno char(1),
	tipo char(1),
	horas smallint,
	codigo_tienda integer NOT NULL,
	CONSTRAINT "Trabajador_pk" PRIMARY KEY (codigo),
	CONSTRAINT turno_chk CHECK (turno = 'M' or turno = 'T')

);
-- ddl-end --
ALTER TABLE public.trabajador OWNER TO postgres;
-- ddl-end --

-- object: public.oferta | type: TABLE --
-- DROP TABLE IF EXISTS public.oferta CASCADE;
CREATE TABLE public.oferta(
	codigo serial NOT NULL,
	fechainicio timestamp,
	fechafin timestamp,
	descuento float,
	codigobarras_producto integer NOT NULL,
	CONSTRAINT "Oferta_pk" PRIMARY KEY (codigo),
	CONSTRAINT descuento_chk CHECK (descuento > 0.0 and descuento <= 1.0),
	CONSTRAINT fecha_chk CHECK (fechainicio < fechafin)

);
-- ddl-end --
ALTER TABLE public.oferta OWNER TO postgres;
-- ddl-end --

-- object: public.iva | type: TABLE --
-- DROP TABLE IF EXISTS public.iva CASCADE;
CREATE TABLE public.iva(
	codigo serial NOT NULL,
	tipo char(1),
	porcentaje float,
	CONSTRAINT "IVA_pk" PRIMARY KEY (codigo),
	CONSTRAINT tipo_chk CHECK (tipo = 'G' or tipo = 'R' or tipo = 'S'),
	CONSTRAINT porcentaje_chk CHECK (porcentaje > 0.0 and porcentaje <= 1.0)

);
-- ddl-end --
ALTER TABLE public.iva OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto(
	codigobarras serial NOT NULL,
	nombre varchar(150),
	preciosiniva money,
	stock integer,
	codigo_iva integer NOT NULL,
	CONSTRAINT "Producto_pk" PRIMARY KEY (codigobarras)

);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.cupon CASCADE;
CREATE TABLE public.cupon(
	codigo serial NOT NULL,
	numero_socio integer,
	CONSTRAINT "Cupon_pk" PRIMARY KEY (codigo)

);
-- ddl-end --
ALTER TABLE public.cupon OWNER TO postgres;
-- ddl-end --

-- object: public.descuento | type: TABLE --
-- DROP TABLE IF EXISTS public.descuento CASCADE;
CREATE TABLE public.descuento(
	cantidad float,
	codigo serial NOT NULL,
	codigo_cupon integer,
	codigobarras_producto integer NOT NULL,
	CONSTRAINT descuento_pk PRIMARY KEY (codigo),
	CONSTRAINT cantidad_chk CHECK (cantidad > 0.0 and cantidad <= 1.0)

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

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.ticket | type: TABLE --
-- DROP TABLE IF EXISTS public.ticket CASCADE;
CREATE TABLE public.ticket(
	identificador serial NOT NULL,
	fechahoraemision timestamp,
	total money,
	codigo_trabajador integer NOT NULL,
	numero_socio integer,
	CONSTRAINT "Ticket_pk" PRIMARY KEY (identificador)

);
-- ddl-end --
ALTER TABLE public.ticket OWNER TO postgres;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT trabajador_fk FOREIGN KEY (codigo_trabajador)
REFERENCES public.trabajador (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.articulo | type: TABLE --
-- DROP TABLE IF EXISTS public.articulo CASCADE;
CREATE TABLE public.articulo(
	codigobarras_producto integer NOT NULL,
	identificador_ticket integer NOT NULL,
	cantidad smallint,
	CONSTRAINT articulo_pk PRIMARY KEY (codigobarras_producto,identificador_ticket),
	CONSTRAINT cantidad_chk CHECK (cantidad  > 0)

);
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.articulo DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.articulo ADD CONSTRAINT producto_fk FOREIGN KEY (codigobarras_producto)
REFERENCES public.producto (codigobarras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.articulo DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.articulo ADD CONSTRAINT ticket_fk FOREIGN KEY (identificador_ticket)
REFERENCES public.ticket (identificador) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.clasificacion | type: TABLE --
-- DROP TABLE IF EXISTS public.clasificacion CASCADE;
CREATE TABLE public.clasificacion(
	nota smallint,
	fecha date,
	codigo_evaluador integer,
	codigo_evaluado serial,
	CONSTRAINT chk_nota CHECK (nota >= 0 and nota <= 10)

);
-- ddl-end --
ALTER TABLE public.clasificacion OWNER TO postgres;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.clasificacion DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.clasificacion ADD CONSTRAINT trabajador_fk FOREIGN KEY (codigo_evaluador)
REFERENCES public.trabajador (codigo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.cupon DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.cupon ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
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

-- object: iva_fk | type: CONSTRAINT --
-- ALTER TABLE public.producto DROP CONSTRAINT IF EXISTS iva_fk CASCADE;
ALTER TABLE public.producto ADD CONSTRAINT iva_fk FOREIGN KEY (codigo_iva)
REFERENCES public.iva (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT socio_fk FOREIGN KEY (numero_socio)
REFERENCES public.socio (numero) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.trabajador ADD CONSTRAINT tienda_fk FOREIGN KEY (codigo_tienda)
REFERENCES public.tienda (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.oferta DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.oferta ADD CONSTRAINT producto_fk FOREIGN KEY (codigobarras_producto)
REFERENCES public.producto (codigobarras) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


