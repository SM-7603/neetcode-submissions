-- table 1
CREATE TABLE videos (
    -- so a primary key obviosly has to be unique
    -- it also can't be null
    -- so a combination of NOT NULL & UNIQUE?
    -- yes -> but a bit more (it's special), it can be made up of multiple columns
    -- i.e. a composite key, a composite primary key if you'll
    -- use a primary key?
    -- to stablish relationships b/w different tables
    id INTEGER PRIMARY KEY,
    title TEXT,
    owner_id INTEGER
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT
);

-- if I remember correctly sometimes the order in which tables were created mattered
-- although that was if the 1st table depends on the 2nd table right?

-- Do not modify below this line --
SELECT 
    c.table_name,
    c.column_name, 
    c.data_type, 
    CASE 
        WHEN kcu.column_name IS NOT NULL THEN 'YES'
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
    c.table_name IN ('users', 'videos')
ORDER BY 
    c.table_name,
    c.ordinal_position;
