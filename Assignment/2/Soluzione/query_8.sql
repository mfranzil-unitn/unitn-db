-- 8. For each mission, find the percentage of participating spies that worked for the CIA.
--  Return the mission name and the corresponding percentage.

WITH tmp AS (
        SELECT mission_id, spy_id,
                agency_id IN (SELECT id FROM secret_agencies WHERE name='CIA') AS is_cia
        FROM works_on wo
        NATURAL JOIN works w
    )
SELECT codename,
    ROUND((SELECT COUNT(DISTINCT spy_id) FROM tmp WHERE m.mission_id=tmp.mission_id AND is_cia)
        * 1.0
        / (SELECT COUNT(DISTINCT spy_id) FROM tmp WHERE m.mission_id=tmp.mission_id), 2)
FROM missions m
