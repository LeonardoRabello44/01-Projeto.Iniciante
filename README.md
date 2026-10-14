[README.md](https://github.com/user-attachments/files/33452283/README.md)
Projeto 1 (Iniciante): Cadastro e Vendas de uma Loja — MySQL

Primeiro projeto da minha trilha de SQL: Básico.

Objetivo

Construir do zero um banco de dados de uma pequena loja (clientes, produtos e vendas) e, 
principalmente, identificar e tratar problemas de qualidade nos dados** antes de analisá-los. 
Os dados são fictícios e foram criados com "sujeiras" propositais para simular situações reais.

Tecnologias

- MySQL 8.0.16+ 
- MySQL Workbench

Modelo de dados

erDiagram
   
CLIENTES ||--o{ VENDAS : realiza
    
PRODUTOS ||--o{ VENDAS : "é vendido em"

    CLIENTES {
        int id_cliente PK
        varchar nome
        varchar email
        varchar cidade
        date data_cadastro
    }
    PRODUTOS {
        int id_produto PK
        varchar nome_produto
        varchar categoria
        decimal preco
        int estoque
    }
    VENDAS {
        int id_venda PK
        int id_cliente FK
        int id_produto FK
        int quantidade
        date data_venda
        varchar forma_pagamento
    }

Estrutura do repositório

projeto-1-loja-mysql/
├── README.md
├── 01_criar_tabelas.sql        # banco + tabelas, chaves primárias e estrangeiras
├── 02_inserir_dados.sql        # dados fictícios 
├── 03_validacao_limpeza.sql    # diagnóstico + tratamento
├── 04_consultas_analise.sql    # perguntas de negócio respondidas com SQL

Problemas de dados encontrados e como foram tratados

| Problema | Como foi detectado | Como foi tratado |
|---|---|---|
| Clientes duplicados (mesmo e-mail em 2 cadastros) | `GROUP BY email HAVING COUNT(*) > 1` | Vendas reapontadas para o cadastro original (`UPDATE`) e duplicados removidos (`DELETE`), sem perder histórico |
| E-mail e cidade vazios (`NULL`) | `IS NULL` + `SUM(coluna IS NULL)` | Cidade → `'NÃO INFORMADA'` com `COALESCE`; e-mail mantido como `NULL` (não se inventa dado) |
| Cidades escritas de formas diferentes (`Rio de Janeiro`, `rio de janeiro`, ` Niterói `) | `GROUP BY cidade` e `cidade <> TRIM(cidade)` | `UPPER(TRIM(cidade))` |
| Categorias inconsistentes (`roupas`, ` Calçados`) | `GROUP BY categoria` | `TRIM` + `UPPER(LEFT())` + `LOWER(SUBSTRING())` |
| Forma de pagamento inconsistente (`pix`, `PIX`, `Pix `) e vazia | `GROUP BY forma_pagamento` | `CASE WHEN` + `COALESCE` → `'Pix'` e `'Não informado'` |
| Venda com quantidade 0 | `WHERE quantidade <= 0` | Registro removido |

Prevenção
Depois da limpeza, o banco passou a **impedir** esses erros com regras (`ALTER TABLE`):
`UNIQUE` no e-mail e `CHECK` para quantidade, preço e estoque.

Perguntas de negócio respondidas

1. Visão geral: clientes, produtos, vendas e faturamento total?

SELECT
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM vendas)   AS total_vendas,
    (SELECT SUM(v.quantidade * p.preco)
       FROM vendas v
       INNER JOIN produtos p ON v.id_produto = p.id_produto) AS faturamento_total;

2. Top 5 produtos mais vendidos?

SELECT p.nome_produto, SUM(v.quantidade) AS unidades_vendidas
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY unidades_vendidas DESC
LIMIT 5;

3. Produtos que mais geram receita?

SELECT p.nome_produto,
       SUM(v.quantidade * p.preco) AS receita
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY receita DESC;

4. Clientes que mais compram?

SELECT c.nome,
       COUNT(*)                    AS numero_de_compras,
       SUM(v.quantidade * p.preco) AS total_gasto
FROM vendas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC
LIMIT 5;

5. Faturamento por mês?

SELECT MONTH(v.data_venda)         AS mes,
       COUNT(*)                    AS numero_de_vendas,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY MONTH(v.data_venda)
ORDER BY mes;

6. Forma de pagamento mais usada?

SELECT forma_pagamento,
       COUNT(*) AS numero_de_vendas
FROM vendas
GROUP BY forma_pagamento
ORDER BY numero_de_vendas DESC;

7. Faturamento por categoria?

SELECT p.categoria,
       SUM(v.quantidade)           AS unidades,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;

8. Ticket médio?

SELECT ROUND(AVG(v.quantidade * p.preco), 2) AS ticket_medio
FROM vendas v
INNER JOIN produtos p ON v.id_produto = p.id_produto;
 
9. Vendas por cidade?

SELECT c.cidade,
       COUNT(*)                    AS numero_de_vendas,
       SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY c.cidade
ORDER BY faturamento DESC

10. Produtos com estoque baixo?

SELECT nome_produto, estoque
FROM produtos
WHERE estoque < 20
ORDER BY estoque;

Principais insights

- Produto mais vendido: Meia (par) 20 unidades
- Categoria que mais fatura: Roupas - R$ 6972,40
- Forma de pagamento mais usada: Pix - 40 vezes
- Mês de maior faturamento: Mes 05 - R$ 5147,60
- Ticket médio: R$ 160,33

O que pratiquei neste projeto

`CREATE TABLE`, chaves primárias e estrangeiras, `INSERT`, `UPDATE`, 
`DELETE`, `WHERE`, `ORDER BY`, `LIMIT`, `COUNT`, `SUM`, `AVG`, `GROUP BY`, 
`HAVING`, `INNER JOIN`, `TRIM`, `UPPER`, `LOWER`, `COALESCE`, `CASE WHEN`, 
`MONTH`, `ALTER TABLE` com `UNIQUE` e `CHECK`.

Limitações (simplificações de projeto)

- Cada venda tem um único produto (não há tabela de itens do pedido).
- O preço usado nos cálculos é o preço atual do produto (não há histórico de preços).
- O estoque não é atualizado automaticamente a cada venda.

Leonardo Varela Rabello
LinkedIn - https://www.linkedin.com/in/leonardo-rabello-8b93164b/?isSelfProfile=true

GitHub - https://github.com/LeonardoRabello44
