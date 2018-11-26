-- 4. For all completed missions with at least three spies,
--  find the average performance grade of the spies that participated.
-- For each such mission, return its name and the average performance.

SELECT codename, ROUND(AVG(grade), 2)
FROM works_on wo
NATURAL JOIN missions m
GROUP BY mission_id, codename
HAVING COUNT(spy_id) >= 3
