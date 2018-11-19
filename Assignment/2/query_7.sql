SELECT Tab.mission_id, M.codename
FROM (
    SELECT L.mission_id as mission_id
    FROM legs L
    GROUP BY L.mission_id
    HAVING COUNT(*) >= 1 
    AND COUNT(*) = COUNT(DISTINCT L.country_id)
) AS Tab
INNER JOIN missions M on Tab.mission_id = M.mission_id;