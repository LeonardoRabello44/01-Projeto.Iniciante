CREATE TABLE produtos (
    id_produto    INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto  VARCHAR(100) NOT NULL,
    categoria     VARCHAR(50),
    preco         DECIMAL(10,2) NOT NULL,
    estoque       INT NOT NULL DEFAULT 0
);
