package pecl3;

import java.sql.*;

public class PECL2 {
    private Statement s;
    private Connection c;
    
    public void Conectar() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch(ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            System.exit(1);
        }
                
        try {
            c = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/supermercado2",
                   "postgres", "postgres");
        } catch(SQLException se) {
            se.printStackTrace();
            System.exit(1);
        }
        
        try {
            s = c.createStatement();
        } catch(SQLException se) {
            se.printStackTrace();
            System.exit(1);
        }
    }
    
    public ResultSet Consultar(String sql) {
        ResultSet rs = null;
        try {
            rs = s.executeQuery(sql);   
        } catch(SQLException se) {
            se.printStackTrace();
            System.exit(1);
        }
        
        return rs;
    }
    
    public void Mostrar(ResultSet rs) {
        int index = 0;
        try {
            while (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                int totalColumnas = rsmd.getColumnCount();
                for (int i = 1; i <= totalColumnas; i++) {
                    if (i > 1) System.out.print(",  ");
                    System.out.print(rsmd.getColumnName(i) + ": " + rs.getString(i));
                }
                System.out.println("");
            }
        } catch(SQLException se) {
            System.out.println("Error grave al mostrar datos"); 
            se.printStackTrace();
            System.exit(1);
        }
    }
    
    public void Ejercicio(String numero, String sql) {
        System.out.println("Ejercicio " + numero + ":");
        ResultSet rs = Consultar(sql);
        Mostrar(rs);        
    }
    
    public void Ejercicio1() {
        Ejercicio("1", "SELECT codigoBarras, precioSinIva FROM producto");
    }
    
    public void Ejercicio2() {
        Ejercicio("2", "select nombre, case when horas < 8 then 'Cajero' else 'Repartidor' end as tipo from trabajador");
    }
    
    public void Ejercicio3() {
        // Considerando que los días laborales son de Lunes a Viernes y que 4 horas diarias * 5 dias hacen 20 semanales
        Ejercicio("3", "SELECT nombre FROM trabajador WHERE horas > 4 AND horas < 8");        
    }
    
    public void Ejercicio4() {
        Ejercicio("4", "select sum(total) as total_facturado from ticket");
    }
    
    public void Ejercicio5() {
        Ejercicio("5", "select sum(total) as total_facturado from ticket");
    }
    
    public void Ejercicio6() {
        Ejercicio("6", "select nombre from producto join descuento on producto.codigobarras = descuento.codigobarras_producto limit 5");
    }
    
    public void Ejercicio7() {
        Ejercicio("7", "SELECT SUM(puntuacion)/COUNT(puntuacion) AS notaMedia FROM opinion");
    }
    
    public void Ejercicio8() {
        Ejercicio("8", "select count(ticket.fechahoraemision) as numero_tickets, nombre, ciudad from ticket join trabajador on ticket.telefonomovil_trabajador = trabajador.telefonomovil join tienda on trabajador.codigo_tienda = tienda.codigo group by telefonomovil_trabajador, nombre, ciudad order by numero_tickets desc");
    }
    
    public void Ejercicio9() {
        Ejercicio("9", "SELECT tienda.codigo AS tienda, COUNT(trabajador) AS nTrabajadores FROM tienda INNER JOIN trabajador ON tienda.codigo = codigo_tienda GROUP BY tienda.codigo ORDER BY nTrabajadores ASC");
    }
    
    public void Ejercicio10() {
        Ejercicio("10", "select nombre, telefonofijo, telefonomovil, (sum(nota) / count(telefonomovil_trabajador)) as media from clasificacion join trabajador on trabajador.telefonomovil = clasificacion.telefonomovil_trabajador group by nombre, telefonofijo, telefonomovil_trabajador, telefonomovil having (sum(nota) / count(telefonomovil_trabajador)) >= 10");
    }
    
    public void Ejercicio11() {
        Ejercicio("11", "SELECT codigoBarras_producto, descuento FROM oferta WHERE fechaInicio BETWEEN '2019/05/01 00:00:00' AND '2019/05/01 23:59:59'");
    }
    
    public void Ejercicio12() {
        Ejercicio("12", "select distinct email from socio join ticket on telefono = telefono_socio join articulo on fechahoraemision = fechahoraemision_ticket join oferta on articulo.codigobarras_producto = oferta.codigobarras_producto and fechainicio >= (DATE('2019-05-31 12:00:00') - 7) and fechainicio <= '2019-05-31 23:59:59'");
    }
    
    public void Ejercicio13() {
        Ejercicio("13", "SELECT nombre FROM (SELECT codigo FROM tienda WHERE ciudad LIKE 'M%') AS temp1 INNER JOIN trabajador ON codigo_tienda = temp1.codigo ORDER BY nombre ASC");
    }
    
    public void Ejercicio14() {
        Ejercicio("14", "select email from socio join cupon on telefono = telefono_socio join descuento on cupon.codigo = codigo_cupon group by email order by sum(cantidad) desc limit 1");
    }
    
    public void Ejercicio15() {
        Ejercicio("15", "SELECT nombre FROM (SELECT nombre, COUNT(*) AS cantidad FROM (SELECT fechahoraemision FROM ticket WHERE total < '€0.00') AS temp1 INNER JOIN articulo ON temp1.fechahoraemision = fechahoraemision INNER JOIN producto ON articulo.codigoBarras_producto = codigoBarras GROUP BY nombre ORDER BY cantidad DESC LIMIT 1) AS temp2");
    }
    
    public void Ejercicio16() {
        Ejercicio("16", "select nombre from ticket join trabajador on ticket.telefonomovil_trabajador = trabajador.telefonomovil join tienda on trabajador.codigo_tienda = tienda.codigo group by telefonomovil_trabajador, nombre, ciudad order by count(telefonomovil_trabajador) desc limit 1");
    }
    
    public void Ejercicio17() {
        Ejercicio("17", "SELECT nombre FROM (SELECT nombre FROM (SELECT telefono_socio, MAX(puntuacion) AS maxima FROM opinion GROUP BY telefono_socio ORDER BY maxima DESC LIMIT 1) AS temp1 INNER JOIN socio ON temp1.telefono_socio = telefono) AS temp2");
    }
    
    public void Ejercicio18() {
        Ejercicio("18", "select fechahoraemision, total from ticket join trabajador on ticket.telefonomovil_trabajador = trabajador.telefonomovil join tienda on trabajador.codigo_tienda = tienda.codigo where nombre like 'A%' and ciudad like 'M%'");
    }
    
    public void Ejercicio19() {
        Ejercicio("19", "SELECT nombre, fechahoraemision AS ticket FROM (SELECT nombre, trabajador.telefonomovil FROM (SELECT codigo FROM tienda WHERE ciudad = 'Alcala de Henares') AS temp1 INNER JOIN trabajador ON temp1.codigo = codigo_tienda) AS temp2 INNER JOIN ticket ON temp2.telefonomovil = telefonomovil_trabajador");
    }
    
    public void Ejercicio20() {
        Ejercicio("20", "select fechahoraemision, nombre from ticket join trabajador on ticket.telefonomovil_trabajador = trabajador.telefonomovil join tienda on trabajador.codigo_tienda = tienda.codigo join articulo on fechahoraemision = fechahoraemision_ticket left join oferta on articulo.codigobarras_producto = oferta.codigobarras_producto where oferta.fechainicio is null and telefono_socio is null and ciudad = 'Alcala de Henares'");
    }
    
}