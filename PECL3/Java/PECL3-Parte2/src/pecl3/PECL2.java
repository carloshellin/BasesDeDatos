package pecl3;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PECL2 {
    private Statement s;
    private Connection c;
    
    public void Conectar(String usuario, String contrasena) {
        try {
            Class.forName("org.postgresql.Driver");
        } catch(ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            System.exit(1);
        }
                
        try {
            c = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/supermercado",
                   usuario, contrasena);
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
    
    public void Desconectar() throws SQLException {
        if (s != null) {
            s.close();
        }
        
        if (c != null) {
            s.close();
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
    
    public void Actualizar(String sql) {
        try {
            s.executeUpdate(sql);
        } catch (SQLException se) {
            se.printStackTrace();
            System.exit(1);
        }
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
    
    public void Probar(String sql) {
        ResultSet rs = Consultar(sql);
        if (rs != null) {
            Mostrar(rs);        
        }
    }

    void ProbarAdministrador() {
        Actualizar("INSERT INTO tienda VALUES (11, 'Torrejón')");
        Actualizar("UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11");
        Probar("SELECT * FROM tienda");
        Actualizar("DELETE FROM tienda WHERE codigo = 11");
        Actualizar("CREATE TABLE prueba (codigo serial PRIMARY KEY)");
        Actualizar("ALTER TABLE prueba ADD COLUMN columna varchar");
        Actualizar("DROP TABLE prueba");
    }

    void ProbarGestor() {
        Actualizar("INSERT INTO tienda VALUES (11, 'Torrejón')");
        Actualizar("UPDATE tienda SET ciudad = 'Alcalá' WHERE codigo = 11");
        Probar("SELECT * FROM tienda");
        Actualizar("DELETE FROM tienda WHERE codigo = 11");
    }

    void ProbarCajero() {        
        Actualizar("INSERT INTO ticket(fechaHoraEmision,total,telefonomovil_trabajador,telefono_socio) VALUES ('2019-11-15 12:36:07','€105,00','655 514 8373','276 501 6392')");
        Actualizar("UPDATE ticket SET total = '€150,00' WHERE fechaHoraEmision = '2019-11-15 12:36:07'");
        Probar("SELECT * FROM ticket");

        Actualizar("INSERT INTO producto(codigobarras,nombre,preciosiniva,stock,porcentaje_iva) VALUES (51,'Seedlings - Mix, Organic','€9,24',564,0.04)");
        Actualizar("UPDATE producto SET preciosiniva = '€10,00' WHERE codigobarras = 51");
        Probar("SELECT * FROM producto");

        Actualizar("INSERT INTO articulo(cantidad,fechahoraemision_ticket,codigobarras_producto,telefonomovil_trabajador_ticket) VALUES (13,'2019-03-15 21:24:03',22, '956 724 8638')");
        Actualizar("UPDATE articulo SET cantidad = 14 WHERE fechahoraemision_ticket = '2019-03-15 21:24:03' AND codigobarras_producto = 22");
        Probar("SELECT * FROM articulo");
    }

    void ProbarReponedor() {
        Actualizar("INSERT INTO producto(codigobarras,nombre,preciosiniva,stock,porcentaje_iva) VALUES (51,'Seedlings - Mix, Organic','€9,24',564,0.04)");
        Actualizar("UPDATE producto SET stock = 565 WHERE codigobarras = 52");
        Probar("SELECT * FROM producto");
        Actualizar("DELETE FROM producto WHERE codigobarras = 52");
    }

    void ProbarSocio() {
        Actualizar("INSERT INTO opinion(texto,fechahora,puntuacion,codigo_tienda,telefono_socio) VALUES ('Me gusta que vendan comida','2016-03-15 18:27:43',10,10,'105 825 4258')");
        Actualizar("UPDATE opinion SET texto = 'Esta bien' WHERE fechahora = '2016-03-15 18:27:43'");
        Probar("SELECT * FROM opinion");
        Actualizar("DELETE FROM opinion WHERE fechahora = '2016-03-15 18:27:43'");
    }
    
}
