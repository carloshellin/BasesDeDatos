package pecl3;

import java.sql.*;
import java.util.Scanner; 

public class Main {
    
    public static void main(String[] args) throws SQLException {
        PECL2 pecl2 = new PECL2();
        
        Scanner scan = new Scanner(System.in);
        int i;
        boolean bucle = true;
        
        while (bucle) {
            System.out.println("--------------------------------");
            System.out.println("1: Juan del grupo adminitrador.");
            System.out.println("2: Pedro del grupo gestor.");
            System.out.println("3: Pablo del grupo cajero.");
            System.out.println("4: Alberto del grupo reponedor.");
            System.out.println("5: Santiago del grupo socio.");
            System.out.println("--------------------------------");
            System.out.println("Selecciona un número de usuario o escribe 0 para terminar el programa:\n");
            i = scan.nextInt();
            
            pecl2.Desconectar();
            
            switch (i) {
                case 0:
                    bucle = false;
                    break;
                case 1:
                    pecl2.Conectar("juan", "juan");
                    pecl2.ProbarAdministrador();
                    break;
                case 2:
                    pecl2.Conectar("pedro", "pedro");
                    pecl2.ProbarGestor();
                    break;
                case 3:
                    pecl2.Conectar("pablo", "pablo");
                    pecl2.ProbarCajero();
                    break;
                case 4:
                    pecl2.Conectar("alberto", "alberto");
                    pecl2.ProbarReponedor();
                    break;
                case 5:
                    pecl2.Conectar("santiago", "santiago");
                    pecl2.ProbarSocio();
                    break;
            }
        }
    }
}
