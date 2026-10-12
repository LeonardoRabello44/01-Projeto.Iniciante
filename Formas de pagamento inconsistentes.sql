SELECT CONCAT('[', forma_pagamento, ']') AS forma_pagamento, COUNT(*) AS quantidade
FROM vendas
GROUP BY forma_pagamento
ORDER BY forma_pagamento;