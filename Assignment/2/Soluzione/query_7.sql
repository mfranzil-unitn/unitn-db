-- 7. Find the missions in which each of its legs took place into a different country.
--  For each such mission, return its id and name.

SELECT mission_id, codename
FROM missions
NATURAL JOIN legs
GROUP BY mission_id, codename
HAVING COUNT(legno) = COUNT(DISTINCT country_id)
