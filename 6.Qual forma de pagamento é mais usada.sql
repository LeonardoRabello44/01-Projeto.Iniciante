SELECT forma_pagamento,
       COUNT(*) AS numero_de_vendas
FROM vendas
GROUP BY forma_pagamento
ORDER BY numero_de_vendas DESC;