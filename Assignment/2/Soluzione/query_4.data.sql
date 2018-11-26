INSERT INTO countries VALUES (1, 'A', 10);

INSERT INTO spies VALUES
    (1, 'q', 1),
    (2, 'w', 1),
    (3, 'e', 1),
    (4, 'r', 1),
    (5, 't', 1)
;

INSERT INTO secret_agencies VALUES (1, 'Q', 1);

INSERT INTO missions VALUES
    (1, 'aaa', '', '', 0, 1, true),
    (2, 'bbb', '', '', 0, 1, true),
    (3, 'ccc', '', '', 0, 1, true)
;

INSERT INTO works_on VALUES
    -- 3 and rounding 1.
    (1, 1, 7),
    (2, 1, 7),
    (3, 1, 8),

    -- At least 3.
    (1, 2, 7),
    (2, 2, 7),

    -- more than 3 and rounding 2.
    (1, 3, 7),
    (2, 3, 7),
    (3, 3, 7),
    (4, 3, 7),
    (5, 3, 7)
;
