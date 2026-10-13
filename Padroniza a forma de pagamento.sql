UPDATE vendas
SET forma_pagamento = CASE
        WHEN LOWER(TRIM(forma_pagamento)) = 'pix' THEN 'Pix'
        ELSE TRIM(forma_pagamento)
    END;
