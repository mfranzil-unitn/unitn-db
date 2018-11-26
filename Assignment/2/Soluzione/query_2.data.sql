INSERT INTO countries VALUES
    (1, 'USA', 10),
    (2, 'AT', 20),
    (3, 'CH', 30),
    (4, 'IT', 30),
    (5, 'DE', 40)
;

INSERT INTO borders VALUES
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 2),
    (3, 4),
    (3, 5),
    (4, 2),
    (4, 3),
    (5, 2),
    (5, 3)
;

INSERT INTO secret_agencies VALUES
    (1, 'CIA', 1),
    (2, 'EU1', 4),
    (3, 'EU2', 5),
    (4, 'EU3', 5)
;

INSERT INTO operates VALUES
    -- < 3
    (1, 1),
    -- All triangles
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    -- Simple triangle
    (3, 2),
    (3, 3),
    (3, 4),
    -- No triangle
    (4, 2),
    (4, 4),
    (4, 5)
;
