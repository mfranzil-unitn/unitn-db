INSERT INTO countries VALUES
    (1, 'q', 10),
    (2, 'w', 20)
;

INSERT INTO secret_agencies VALUES
    (1, 'CIA', 1),
    (2, 'FBI', 1)
;

INSERT INTO missions VALUES
    (1, 'aaa', '', '', 10, 1, true),
    (2, 'bbb', '', '', 10, 1, true),
    (3, 'ccc', '', '', 8, 1, true)
;

INSERT INTO spies VALUES
    (1, 'big', 1, true),
    (2, 'small', 1, true),
    (3, 'ugly', 1, true)
;

INSERT INTO works VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (3, 2)
;

INSERT INTO works_on VALUES
    -- Simple, 1/2
    (1, 1, 0),
    (2, 1, 0),

    -- Simple, 0
    (2, 2, 0),

    -- Corner case: both CIA and FBI, 1/2
    (2, 3, 0),
    (3, 3, 0)
;
