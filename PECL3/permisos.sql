GRANT ALL PRIVILEGES ON DATABASE supermercado TO administrador;
GRANT ALL PRIVILEGES ON SCHEMA public TO administrador;
GRANT ALL PRIVILEGES ON ALL tables IN schema public TO administrador;

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO gestor;
GRANT INSERT, UPDATE, DELETE, SELECT ON ALL tables IN schema public TO gestor;

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO cajero;
GRANT INSERT, UPDATE, SELECT ON ticket, producto, articulo TO cajero;

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO reponedor;
GRANT INSERT, UPDATE, SELECT, DELETE ON producto TO reponedor;

REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO socio;
GRANT INSERT, UPDATE, SELECT, DELETE ON opinion TO socio;