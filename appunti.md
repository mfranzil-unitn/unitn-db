# Appunti di Database

## Informazioni sul database locale

> Indirizzo: `localhost`
>
> Password: `1234`
>
> Porta: `5342`

## Come connettersi al server UniTN

```shell
"C:\Program Files\PostgreSQL\10\bin\psql.exe" -h sci-didattica.unitn.it -U db_016 -d db_016
```

## Translating an ER

- **Many to Many**:
     ```SQL
    CREATE TABLE Relation (
        attributes ...,
        ent1key SERIAL,
        ent2key SERIAL,
        PRIMARY KEY(ent1key, ent2key)
        FOREIGN KEY(ent1key) REFERENCES Ent1,
        FOREIGN KEY(ent2key) REFERENCES Ent2
    )
    ```
- **Many to One (frecia sotile)**:
    ```SQL
    CREATE TABLE Relation (
        attributes ...,
        manykey SERIAL,
        onekey SERIAL,
        PRIMARY KEY(onekey)
        FOREIGN KEY(manykey) REFERENCES Many,
        FOREIGN KEY(onekey) REFERENCES One
    )
    ```
- **Many to One Total Participation (frecia grosa)**:
    ```SQL
    CREATE TABLE One_Relation (
        attributes_one ...,
        attributes_relation ...,
        onekey SERIAL,
        manykey SERIAL NOT NULL,
        PRIMARY KEY(onekey),
        FOREIGN KEY(manykey) REFERENCES Many
          ON DELETE NO ACTION
    )
    ```
- **Weak Entities**:
     ```SQL
    CREATE TABLE Weak_Relation (
        attributes ...,
        parentkey SERIAL NOT NULL,
        childkey SERIAL,
        PRIMARY KEY(parentkey, childkey),
        FOREIGN KEY(parentkey) REFERENCES Parent
          ON DELETE CASCADE
    )
    ```
- **Is-A**:
  
    Two approaches:  either create only the subclasses adding all the Parent class attributes into it, or create both Parent and Child subclasses, recording shared info in the Parent class and extra info in the Child classes with the ON DELETE CASCADE on.

    ```SQL
    CREATE TABLE Parent (
        shared_attributes ...,
        parentkey SERIAL,
        PRIMARY KEY(parentkey)
    )

    CREATE TABLE Child (
        specific_attributes ...,
        parentkey SERIAL,
        PRIMARY KEY(parentkey),
        FOREIGN KEY(parentkey) REFERENCES Parent
          ON DELETE CASCADE
    )
    ```
- **Aggregation**:
  
    ```SQL
        CREATE TABLE Aggregation_Relation (
            attiributes SERIAL,
            first_key_in_aggregation SERIAL, 
            second_key_in_aggregation SERIAL,
            other_key SERIAL,
            PRIMARY KEY (all_the_keys),
            FOREIGN KEY (first_key_in_aggregation) REFERENCES (...),
            FOREIGN KEY (second_key_in_aggregation) REFERENCES (...),
            FOREIGN KEY (other_key) REFERENCES (...)
        )
    ```

## Relational Algebra

Relation algebra is composed from *relational symbol*. They all take relations as input and return relations as output. They can therefore be composed.

### Project - $\pi$

Deletes attributes that are NOT in the list:
$$\pi_{attributes} (Relation)$$

### Select - $\sigma$

Selects rows that satisfy a condition ($\ge, \le, =, >, <$...or combination of these):
$$\sigma_{condition}(Relation)$$

### Union, Intersection, Set-difference - $\cup, \cap, -$

These three operators yield the union, intersection and set-difference ($S1 - S2 :=$ What is in S1, but not in S2). The two relations must be *union-compatible*, meaning they have the same number of fields of the same type.

### Cross-product - $\times$

Each row of a relation is paired with the relation of the other. Must be able to resolve conflicts of fields with the same name.

### Rename - $\rho$

Used in conjunction with another operator to rename fields.

$$\rho(name, relation)$$

### Join - $\bowtie$

Similar to cross-product, but uses a condition to choose rows from both relations. Can be distinguished in *condition or theta join* where a condition is provided, *equi-join* where the condition to be satisfied is an equality, and *natural-join* which executes equi-join in all attributes.

$$S1 \bowtie_{S1.sid < R1.sid} R1$$

### Division - $/$

Not supported in SQL. Given two fields $x, y$, both contained in A and $y$ only contained in B, the division shall return all the $x$ tuples that don't match each $y$ coming from B in A.

## Queries - Important keywords

```SQL
SELECT DISTINCT -- DISTINCT removes duplicates before output

'B_%B' -- pattern matching: % means 0+ chars, _ means 1+ chars

---takes two union compatible sets and merges them
-- with the correct operation
UNION        -- relative to the OR
INTERSECT    -- relative to the AND
DIFFERENCE

... WHERE 'parameter' IN ('NESTED_QUERY')
... WHERE 'parameter' NOT IN ('NESTED_QUERY') -- Computes NESTED_QUERY first and then checks the condition. Returns true if and only if parameter is found in the table of the nested query.

-- The condition with in can be merged in the WHERE of the nested_query
-- (but also using SELECT * to make the attribute available); the query will output the same results
... WHERE EXISTS ('NESTED_QUERY') -- returns true if at least one record is found

... WHERE UNIQUE ('NESTED_QUERY') -- returns True only if all the returned rows are not identical

... WHERE 'condition' > ANY ('N_S') -- where op is >=, >, =, <, <=; same as above; checks if condition is higher than ANY of the values found in the subquery; uses lazy evaluation
... WHERE 'condition' > ALL ('N_S')

-- aggregate operators: used in SELECT

COUNT (*)  -- returns the number of rows (counts duplicates!)
COUNT ( [DISTINCT] A) -- returns the number of distinct rows
SUM ( [DISTINCT] A)  -- sums all the values
AVG ( [DISTINCT] A)
MAX (A) -- returns the HIGHEST
MIN (A)  

GROUP BY 'grouping_parameter'
HAVING 'group_qualification' -- used to group output rows and then compute an additional qualification. HAVING must be a condition

FROM 'table' JOIN 'table2' ON 'attribute1 = attribute2' -- Normal join

FROM 'table' NATURAL JOIN 'table2' -- niente constraint! Unisce tutti i campi in comune! Quando

-- aggiungere eventuali left / right join

```

## Tipi di dato

```SQL
BOOLEAN

CHAR(N) -- with space padding
VARCHAR(N)  -- without space padding
TEXT -- unlimited

SMALLINT
INT
SERIAL --auto

TIME, DATE, TIMESTAMP, TIMESTAMPTZ, INTERVAL

UUID, JSON,  --etc...
```

### Comandi

```SQL
-- Table creation:
CREATE TABLE Esempio (
    var1 id1,
    var2 id2,
    PRIMARY KEY (var1),  -- Primary key definition
    FOREIGN KEY (var2) REFERENCES Esempio2,  -- Foreign key definition
)

-- Constraints:
CHECK -- (condition)
UNIQUE
NOT NULL

ON DELETE
    NO ACTION
    CASCADE  -- remove all tuples refering to this
    SET NULL -- set to null
    SET DEFAULT

-- Alteration:
ALTER TABLE
    ADD COLUMN
    DROP COLUMN
    ALTER COLUMN -- [name] ( SET / DROP NOT NULL ) (...)

-- Views:

CREATE VIEW 'VIEW_NAME' AS ('SQL_QUERY')

-- Deletion:
DROP VIEW
DROP TABLE
DROP DATABASE

TRUNCATE TABLE (CASCADE)

DELETE FROM Esempio3
WHERE condition

-- Get all tables
SELECT table_name FROM information_schema.tables WHERE table_schema='public'
```
