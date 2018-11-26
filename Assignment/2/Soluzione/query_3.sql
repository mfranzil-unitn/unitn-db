-- 3. Find agencies that are in potential trouble. An agency is in trouble
--  if the dominant nationality of its spies is a country that borders
--  with the country that the agency serves.

WITH country_presence AS (
        SELECT w.agency_id, s.country_id, COUNT(s.id) AS n
        FROM works w
        JOIN spies s ON w.spy_id=s.id
        GROUP BY w.agency_id, s.country_id
    ), dominants AS (
        SELECT cp.agency_id, cp.country_id
        FROM country_presence cp
        WHERE cp.n >= (
            SELECT MAX(n) AS max_n
            FROM country_presence inner_cp
            WHERE inner_cp.agency_id=cp.agency_id
        )
    )
SELECT agency_id
FROM dominants dom
JOIN secret_agencies sa ON dom.agency_id=sa.id
JOIN borders b ON country_id1=sa.serves_country_id
GROUP BY agency_id
HAVING EVERY(dom.country_id <> sa.serves_country_id) AND
    -- ANY wo/subquery -> bool_or
    -- https://www.postgresql.org/docs/current/functions-aggregate.html
    bool_or(country_id2 = dom.country_id)
