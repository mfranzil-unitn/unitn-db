SELECT M1.codename
FROM missions M1
WHERE M1.duration = (
    SELECT DISTINCT M.duration
    FROM missions M
    GROUP BY M.duration
    ORDER BY M.duration DESC
    LIMIT 1 OFFSET 1
);