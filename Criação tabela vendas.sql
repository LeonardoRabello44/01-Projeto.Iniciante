CREATE TABLE vendas (
    id_venda         INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente       INT NOT NULL,
    id_produto       INT NOT NULL,
    quantidade       INT NOT NULL,
    data_venda       DATE NOT NULL,
    forma_pagamento  VARCHAR(30),
    CONSTRAINT fk_vendas_clientes FOREIGN KEY (id_cliente)
        REFERENCES clientes (id_cliente),
    CONSTRAINT fk_vendas_produtos FOREIGN KEY (id_produto)
        REFERENCES produtos (id_produto)
);
