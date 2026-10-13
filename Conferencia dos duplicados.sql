SELECT COUNT(*) AS vendas_ainda_nos_duplicados
FROM vendas
WHERE id_cliente IN (17, 18);