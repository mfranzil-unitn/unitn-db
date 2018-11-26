-- 10. For each country, find the number of missions that had at least one leg in this country.
--  For each such country, return its name and the corresponding number of missions.

SELECT name, COUNT(DISTINCT mission_id)
FROM countries c
LEFT JOIN legs l ON c.id=l.country_id
GROUP BY c.id
