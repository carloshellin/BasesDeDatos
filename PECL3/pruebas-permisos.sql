-- Conectar como juan con contraseña juan y pedro con contraseña pedro para ejecutar lo siguiente:
INSERT INTO tienda VALUES (11, 'Torrejón');
UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11;
SELECT * FROM tienda;
DELETE FROM tienda WHERE codigo = 11;
CREATE TABLE prueba (codigo serial PRIMARY KEY);
ALTER TABLE prueba ADD COLUMN columna varchar;
DROP TABLE prueba;
--

-- Conectar como pablo con contraseña pablo para ejecutar lo siguiente:
INSERT INTO tienda VALUES (11, 'Torrejón');
UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11;
SELECT * FROM tienda;
DELETE FROM tienda WHERE codigo = 11;
CREATE TABLE prueba (codigo serial PRIMARY KEY);
ALTER TABLE prueba ADD COLUMN columna varchar;
DROP TABLE prueba;

INSERT INTO ticket(fechaHoraEmision,total,telefonomovil_trabajador,telefono_socio) VALUES ('2019-11-15 12:36:07','€105,00','655 514 8373','276 501 6392');
UPDATE ticket SET total = '€150,00' WHERE fechaHoraEmision = '2019-11-15 12:36:07';
SELECT * FROM ticket;
DELETE FROM ticket WHERE identificador = 27;

INSERT INTO producto(codigobarras,nombre,preciosiniva,stock,porcentaje_iva) VALUES (51,'Seedlings - Mix, Organic','€9,24',564,0.04);
UPDATE producto SET preciosiniva = '€10,00' WHERE codigobarras = 51;
SELECT * FROM producto;
DELETE FROM producto WHERE codigobarras = 51;

INSERT INTO articulo(cantidad,fechahoraemision_ticket,codigobarras_producto,telefonomovil_trabajador_ticket) VALUES (13,'2019-03-15 21:24:03',22, '956 724 8638');
UPDATE articulo SET cantidad = 14 WHERE fechahoraemision_ticket = '2019-03-15 21:24:03' AND codigobarras_producto = 22;
SELECT * FROM articulo;
DELETE FROM articulo WHERE fechahoraemision_ticket = '2019-03-15 21:24:03' AND codigobarras_producto = 22;
--

-- Conectar como alberto con contraseña alberto para ejecutar lo siguiente:
INSERT INTO tienda VALUES (11, 'Torrejón');
UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11;
SELECT * FROM tienda;
DELETE FROM tienda WHERE codigo = 11;
CREATE TABLE prueba (codigo serial PRIMARY KEY);
ALTER TABLE prueba ADD COLUMN columna varchar;
DROP TABLE prueba;

INSERT INTO producto(codigobarras,nombre,preciosiniva,stock,porcentaje_iva) VALUES (51,'Seedlings - Mix, Organic','€9,24',564,0.04);
UPDATE producto SET stock = 565 WHERE codigobarras = 51;
SELECT * FROM producto;
DELETE FROM producto WHERE codigobarras = 51;
--

-- Conectar como santiago con contraseña santiago para ejecutar lo siguiente:
INSERT INTO tienda VALUES (11, 'Torrejón');
UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11;
SELECT * FROM tienda;
DELETE FROM tienda WHERE codigo = 11;
CREATE TABLE prueba (codigo serial PRIMARY KEY);
ALTER TABLE prueba ADD COLUMN columna varchar;
DROP TABLE prueba;

INSERT INTO opinion(texto,fechahora,puntuacion,codigo_tienda,telefono_socio) VALUES ('Me gusta que vendan comida','2016-03-15 18:27:43',10,10,'105 825 4258');
UPDATE opinion SET texto = 'Esta bien' WHERE fechahora = '2016-03-15 18:27:43';
SELECT * FROM opinion;
DELETE FROM opinion WHERE fechahora = '2016-03-15 18:27:43';
--