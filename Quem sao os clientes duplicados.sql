SELECT id_cliente, nome, email, data_cadastro
FROM clientes
WHERE email IN (
    SELECT email
    FROM (SELECT email FROM clientes GROUP BY email HAVING COUNT(*) > 1) AS d
)
ORDER BY email, id_cliente;