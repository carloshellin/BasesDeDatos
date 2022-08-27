-- /// TRIGGERS \\\
-- calculaCoste
create or replace function calculaCoste() returns Trigger
as
$$
declare
	desccupon float8 := (select descuento.cantidad
					    from articulo join ticket on ticket.fechahoraemision = new.fechahoraemision_ticket and ticket.telefonomovil_trabajador = new.telefonomovil_trabajador_ticket
					   				  join cupon on ticket.telefono_socio = cupon.telefono_socio
					    			  join descuento on cupon.codigo = descuento.codigo_cupon and articulo.codigobarras_producto = descuento.codigobarras_producto);
	descoferta float8 := (select descuento 
						 from articulo join ticket on ticket.fechahoraemision = new.fechahoraemision_ticket and ticket.telefonomovil_trabajador = new.telefonomovil_trabajador_ticket
						 			   join producto on new.codigobarras_producto = producto.codigobarras
						 			   join oferta on producto.codigobarras = oferta.codigobarras_producto and fechahoraemision between fechainicio and fechainicio + interval '7 days');
	precioconiva float8 := (select (preciosiniva::numeric::float8 * (porcentaje_iva + 1) * 0.01)
						    from articulo join producto on new.codigobarras_producto = producto.codigobarras);
begin

update ticket
set total = (new.cantidad * (precioconiva - coalesce(descoferta, 0) - coalesce(desccupon, 0)))::numeric::money
from ticket AS ti
where ti.fechahoraemision = new.fechahoraemision_ticket and ti.telefonomovil_trabajador = new.telefonomovil_trabajador_ticket;

return new;
End
$$
Language plpgsql;

create trigger Ticket_Update after insert on articulo
for each row
execute procedure calculaCoste();
-- drop trigger Ticket_Update on articulo

-- calculaStock
create or replace function calculaStock() returns Trigger
as
$$
begin

update producto
set stock = pr.stock - new.cantidad
from producto AS pr
where pr.codigobarras = new.codigobarras_producto;

return new;
end
$$
Language plpgsql;

create trigger Stock_update after insert on articulo
for each row
execute procedure calculaStock();
-- drop trigger Stock_Update on articulo