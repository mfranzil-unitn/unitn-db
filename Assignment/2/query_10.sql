SELECT C1.name, COALESCE(Counters.count, 0)
FROM (
    SELECT C.name, COUNT(DISTINCT L.mission_id)
    FROM countries C 
    JOIN legs L ON C.id = L.country_id 
    GROUP BY C.id
) AS Counters
FULL OUTER JOIN countries C1
ON C1.name = Counters.name;