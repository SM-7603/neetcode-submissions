CREATE TABLE orders (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    -- interesting syntax, I almost expected a COMPOSITE or COMPOUND key word, but this makes sense
    PRIMARY KEY (order_id, product_id)
    -- could the data type of a composite primary key be different from idk, what it's made of?
    -- str + int = str right?
    -- also I could use an alias for the primary key right?

    -- so here's some clarity:
    -- composite primary keys aren't a new column
    -- it's just a rule check over multiple columns
    -- so something like 100 + "5" != "100-5" or "1005" or like excel 100 & "s" = 100s
    
    -- and as for the alias thing, firstly it's not a column
    -- Kind of, yes. You can name the constraint but it's not not an alias you can query
    -- because it's is not a column. It is just the name of the rule.
);

-- Do not modify below this line --
SELECT 
    c.table_name,
    c.column_name, 
    c.data_type, 
    CASE 
        WHEN kcu.column_name IS NOT NULL THEN 
            CASE 
                WHEN COUNT(*) OVER (PARTITION BY kcu.constraint_name) > 1 THEN 'YES (Composite)'
                ELSE 'YES'
            END
        ELSE 'NO'
    END AS is_primary_key
FROM 
    information_schema.columns c
LEFT JOIN 
    information_schema.key_column_usage kcu
    ON c.table_name = kcu.table_name 
    AND c.column_name = kcu.column_name
LEFT JOIN 
    information_schema.table_constraints tc
    ON kcu.constraint_name = tc.constraint_name
    AND tc.constraint_type = 'PRIMARY KEY'
WHERE 
    c.table_name = 'orders'
ORDER BY 
    c.ordinal_position;
