-- table 1
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    name TEXT
);

-- what's FK?
-- A foreign key does not have to be unique, 
-- but it must match an existing value in the referenced column. 
-- The referenced column must be a primary key or have a unique constraint.  

-- table 2
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    -- we don't care how many times the FK is repeated
    -- employees in this case the employee ID must be unique
    -- although the departments don't have the unique
    -- what I mean is, they don't have to be unique in the employees table 
    -- different employees can have the same departments
    -- i know it's basic stuff, but it's worth verbalizing? writing these out explicitly.
    department_id INTEGER REFERENCES departments(id)
);

-- Do not modify below this line --
SELECT 
    c.table_name,
    c.column_name, 
    c.data_type,
    CASE 
        WHEN pk.column_name IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END AS is_primary_key,
    CASE 
        WHEN fk.column_name IS NOT NULL THEN 
            'YES (References ' || fk.foreign_table_name || '.' || fk.foreign_column_name || ')'
        ELSE 'NO'
    END AS is_foreign_key
FROM 
    information_schema.columns c
LEFT JOIN (
    SELECT kcu.table_name, kcu.column_name
    FROM information_schema.key_column_usage kcu
    JOIN information_schema.table_constraints tc 
        ON kcu.constraint_name = tc.constraint_name
    WHERE tc.constraint_type = 'PRIMARY KEY'
) pk ON c.table_name = pk.table_name AND c.column_name = pk.column_name
LEFT JOIN (
    SELECT 
        kcu.table_name, 
        kcu.column_name, 
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name
    FROM information_schema.key_column_usage kcu
    JOIN information_schema.referential_constraints rc 
        ON kcu.constraint_name = rc.constraint_name
    JOIN information_schema.constraint_column_usage ccu 
        ON rc.unique_constraint_name = ccu.constraint_name
) fk ON c.table_name = fk.table_name AND c.column_name = fk.column_name
WHERE 
    c.table_name IN ('departments', 'employees')
ORDER BY 
    c.table_name,
    c.ordinal_position;
