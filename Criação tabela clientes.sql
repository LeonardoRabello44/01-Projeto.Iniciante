CREATE TABLE clientes (
    id_cliente     INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    email          VARCHAR(100),
    cidade         VARCHAR(60),
    data_cadastro  DATE NOT NULL
);