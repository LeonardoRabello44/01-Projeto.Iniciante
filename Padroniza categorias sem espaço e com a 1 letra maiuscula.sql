UPDATE produtos
SET categoria = CONCAT(
        UPPER(LEFT(TRIM(categoria), 1)),
        LOWER(SUBSTRING(TRIM(categoria), 2))
    );
