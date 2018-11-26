INSERT INTO countries VALUES
    (1, 'q', 10),
    (2, 'w', 20)
;

INSERT INTO secret_agencies VALUES (1, 'A', 1);

INSERT INTO missions VALUES
    (1, 'aaa', '', '', 10, 1, true),
    (2, 'bbb', '', '', 10, 1, true),
    (3, 'ccc', '', '', 8, 1, true),
    (4, 'ddd', '', '', 8, 1, true)
;

INSERT INTO legs VALUES
    -- single leg
    (1, 1, 1),
    -- 2 leg same country
    (2, 1, 1),
    (2, 2, 1),
    -- 2 leg  different country
    (3, 1, 1),
    (3, 2, 2),
    -- Random legno, different country
    (4, 10, 1),
    (4, 20, 2)
;
