select
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM vendas)   AS total_vendas,
    (SELECT SUM(v.quantidade * p.preco)
       FROM vendas v
       INNER JOIN produtos p ON v.id_produto = p.id_produto) AS faturamento_total;