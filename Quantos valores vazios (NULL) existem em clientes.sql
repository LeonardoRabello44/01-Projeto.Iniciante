SELECT
    COUNT(*)                    AS total_clientes,
    SUM(email  IS NULL)         AS sem_email,
    SUM(cidade IS NULL)         AS sem_cidade
FROM clientes;