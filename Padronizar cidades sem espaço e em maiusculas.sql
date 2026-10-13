UPDATE clientes
SET cidade = COALESCE(UPPER(TRIM(cidade)), 'NÃO INFORMADA');