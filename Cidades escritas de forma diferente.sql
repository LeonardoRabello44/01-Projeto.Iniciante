SELECT cidade, COUNT(*) AS quantidade
FROM clientes
GROUP BY cidade
ORDER BY cidade;