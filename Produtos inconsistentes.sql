SELECT CONCAT('[', categoria, ']') AS categoria, COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria
ORDER BY categoria;
