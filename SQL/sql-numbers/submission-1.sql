CREATE TABLE bank_accounts (
    id BIGINT PRIMARY KEY,
    -- NUMERIC == DECIMAL, identical/congruent whatever you what...
    -- the point being, for consistency just use one, let's go with NUMERIC
    -- what's the size of this again?
    -- i actually don't know, is it dynamic? unlike 
    -- {SMALLINT, INTEGER, FLOAT, BIGINT, DOUBLE PRECISION} = {2 bytes, 4 bytes, 4 bytes, 8 bytes, 8 bytes}
    balance NUMERIC(20, 2),
    interest_rate NUMERIC(5, 2),
    number_of_owners SMALLINT
);

-- Do not modify below this line --
INSERT INTO bank_accounts (id, balance, interest_rate, number_of_owners) VALUES
    (1, 123451234512345123.45, 123.45, 1);

SELECT 
    ba.*,
    (SELECT STRING_AGG(column_name || ' ' || data_type || CASE WHEN numeric_precision IS NOT NULL THEN '(' || numeric_precision || ',' || numeric_scale || ')' ELSE '' END, ', ')
     FROM information_schema.columns 
     WHERE table_name = 'bank_accounts') AS column_types
FROM 
    bank_accounts ba;
