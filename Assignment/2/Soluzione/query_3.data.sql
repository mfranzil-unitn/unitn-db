INSERT INTO countries VALUES
    (1, 'C_M', 10),
    (2, 'C_N', 20),
    (3, 'C_B', 30),
    (4, 'C_V', 40),
    (5, 'C_C', 50)
;

INSERT INTO secret_agencies VALUES
    (1, 'CIA', 1),
    (2, 'FBI', 2),
    (3, 'ASD', 3),
    (4, 'FOO', 1),
    (5, 'BAR', 5)
;

INSERT INTO spies VALUES
    (1, 'q', 1),
    (2, 'w', 1),
    (3, 'e', 2),
    (4, 'r', 2),
    (5, 't', 2),

    (6, 'y', 2),
    (7, 'u', 2),
    (8, 'i', 3),

    (9,  'o', 2),
    (10, 'p', 3),

    (11, 'a', 4)
;

INSERT INTO works VALUES
    --> Countries 1 to 4: all borders each other.

    -- CIA in trouble (3 vs 2) - simple
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),

    -- FBI not in trouble (1 vs 2) - simple
    (6, 2),
    (7, 2),
    (8, 2),

    --  not in trouble (1 vs 1)
    (9,  3),
    (10, 3),

    --  not in trouble (1 vs 1 vs 1 vs 2)
    (1, 4),
    (2, 4),
    (9,  4),
    (10, 4),
    (11, 4),

    -- test country filtering (5 does not border w/2)
    (3, 5),
    (4, 5)
;

INSERT INTO borders VALUES
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 1),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 2),
    (3, 4),
    (4, 1),
    (4, 2),
    (4, 3),

    (5, 1), (1, 5)
;
