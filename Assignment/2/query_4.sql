SELECT M.codename,
       ROUND(AVG(W.grade),2)
FROM missions M
JOIN works_on W on W.mission_id = M.mission_id
JOIN spies S on W.spy_id = S.id
WHERE completed = TRUE 
AND 3 <= (
    SELECT COUNT(*)
    FROM works_on W 
    JOIN spies S on W.spy_id = S.id
    GROUP BY mission_id
    HAVING mission_id = M.mission_id
)
GROUP BY M.mission_id;