-- 6. Find the missions with the second highest duration.
--  For each such mission, return its name.

SELECT codename
FROM missions
WHERE duration = ( -- get second
    SELECT MAX(duration)
    FROM missions
    WHERE duration < ( -- remove first
        SELECT MAX(duration)
        FROM missions
    )
)
