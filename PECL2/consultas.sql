-- 1
SELECT codigoBarras, precioSinIva FROM producto;

-- 2
select nombre, case tipo when 'C' then 'Cajero' else 'Reponedor' end as tipo from trabajador;  

-- 3
SELECT nombre
FROM trabajador
WHERE tipo = 'R' AND horas > 4; -- Considerando que los días laborales son de Lunes a Viernes y que 4 horas diarias * 5 dias hacen 20 semanales

-- 4
select sum(total) as total_facturado from ticket;

-- 5
SELECT codigo, nombre, cantidad 
FROM (SELECT cupon.codigo, codigoBarras_producto, cantidad 
	 FROM cupon
	 INNER JOIN descuento ON cupon.codigo = codigo_cupon) AS temp1
INNER JOIN producto ON codigoBarras = temp1.codigoBarras_producto;

-- 6
select nombre from producto join descuento on producto.codigobarras = descuento.codigobarras_producto limit 5;

-- 7
SELECT SUM(puntuacion)/COUNT(puntuacion) AS notaMedia FROM opinion;

-- 8
select count(ticket.identificador) as numero_tickets, nombre, ciudad from ticket join trabajador on ticket.codigo_trabajador = trabajador.codigo join tienda on trabajador.codigo_tienda = tienda.codigo group by codigo_trabajador, nombre, ciudad order by numero_tickets desc;

-- 9
SELECT tienda.codigo AS tienda, COUNT(trabajador) AS nTrabajadores 
FROM tienda
INNER JOIN trabajador ON tienda.codigo = codigo_tienda
GROUP BY tienda.codigo
ORDER BY nTrabajadores ASC;

-- 10
select nombre, telefonofijo, telefonomovil, (sum(nota) / count(codigo_evaluador)) as media from clasificacion join trabajador on trabajador.codigo = clasificacion.codigo_evaluado group by nombre, telefonofijo, codigo_evaluador, telefonomovil having (sum(nota) / count(codigo_evaluador)) >= 10;

-- 11
SELECT codigoBarras_producto, descuento 
FROM oferta
WHERE fechaInicio BETWEEN '2019/05/01 00:00:00' AND '2019/05/01 23:59:59';

-- 12
select distinct email from socio join ticket on numero = numero_socio join articulo on identificador = identificador_ticket join oferta on articulo.codigobarras_producto = oferta.codigobarras_producto and fechainicio >= (DATE('2019-05-31 12:00:00') - 7) and fechafin <= '2019-05-31 23:59:59';

-- 13
SELECT nombre
FROM (SELECT codigo FROM tienda
	 WHERE ciudad LIKE 'M%') AS temp1
INNER JOIN trabajador ON codigo_tienda = temp1.codigo
ORDER BY nombre ASC;

-- 14
select email from socio join cupon on numero = numero_socio join descuento on cupon.codigo = codigo_cupon group by email order by sum(cantidad) desc limit 1;

-- 15
SELECT nombre
FROM (SELECT nombre, COUNT(*) AS cantidad
	  FROM (SELECT identificador
	        FROM ticket
			WHERE total < '€0.00') AS temp1
	  INNER JOIN articulo ON temp1.identificador = identificador
	  INNER JOIN producto ON articulo.codigoBarras_producto = codigoBarras
	  GROUP BY nombre
	  ORDER BY cantidad DESC
	  LIMIT 1) AS temp2;

-- 16
select nombre from ticket join trabajador on ticket.codigo_trabajador = trabajador.codigo join tienda on trabajador.codigo_tienda = tienda.codigo group by codigo_trabajador, nombre, ciudad order by count(codigo_trabajador) desc limit 1;

-- 17
SELECT nombre
FROM (SELECT nombre 
	  FROM (SELECT numero_socio, MAX(puntuacion) AS maxima
	  		FROM opinion
	  		GROUP BY numero_socio
	  		ORDER BY maxima DESC
	   		LIMIT 1) AS temp1
	  INNER JOIN socio ON temp1.numero_socio = numero) AS temp2;

-- 18
select identificador, fechahoraemision, total from ticket join trabajador on ticket.codigo_trabajador = trabajador.codigo join tienda on trabajador.codigo_tienda = tienda.codigo where nombre like 'A%' and ciudad like 'M%';

-- 19
SELECT nombre, identificador AS ticket
FROM (SELECT nombre, trabajador.codigo
	  FROM (SELECT codigo
		    FROM tienda
		    WHERE ciudad = 'Alcala de Henares') AS temp1
	  INNER JOIN trabajador ON temp1.codigo = codigo_tienda) AS temp2
INNER JOIN ticket ON temp2.codigo = codigo_trabajador;

-- 20
select identificador, nombre from ticket join trabajador on ticket.codigo_trabajador = trabajador.codigo join tienda on trabajador.codigo_tienda = tienda.codigo join articulo on identificador = identificador_ticket left join oferta on articulo.codigobarras_producto = oferta.codigobarras_producto where oferta.codigo is null and numero_socio is null and ciudad = 'Alcala de Henares';
