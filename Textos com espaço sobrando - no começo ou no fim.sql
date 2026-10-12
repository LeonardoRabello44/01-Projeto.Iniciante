SELECT id_cliente, CONCAT('[', cidade, ']') AS cidade_com_colchetes
FROM clientes
WHERE cidade <> TRIM(cidade);