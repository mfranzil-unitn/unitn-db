INSERT INTO countries VALUES (1, 'A', 10);

INSERT INTO spies VALUES
    (1, '007', 1),
    (2, '008', 1),
    (3, '009', 1)
;

INSERT INTO secret_agencies VALUES (1, 'Q', 1);

INSERT INTO missions VALUES
    (1, 'aaa', 'A_1', 'A_2', 0, 1, true),
    (2, 'bbb', 'B_1', 'B_2', 0, 1, true),
    (3, 'ccc', 'C_1', 'C_2', 0, 1, true)
;

INSERT INTO works_on VALUES
    -- Both works
    (1, 1, 7),
    (2, 1, 7),

    -- Only one.
    (1, 2, 7),
    (3, 2, 7)
;
