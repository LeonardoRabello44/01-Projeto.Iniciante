SELECT email, COUNT(*) AS quantidade
FROM clientes
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;