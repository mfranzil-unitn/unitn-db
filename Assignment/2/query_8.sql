SELECT codename, 
       COALESCE(
           ROUND(
               cia_count::NUMERIC / spy_count,
               2
            ), 0.00
        ) AS percentage
FROM (
    SELECT mission_id,
           COUNT(*) AS spy_count 
    FROM works_on WO
    GROUP BY mission_id
) AS All_Spies
LEFT OUTER JOIN (
    SELECT M.mission_id,
           COUNT(DISTINCT w.spy_id) AS cia_count
    FROM missions M
    JOIN works_on WO ON M.mission_id = WO.mission_id
    JOIN works W ON WO.spy_id = W.spy_id
    JOIN secret_agencies A ON W.agency_id = A.id
    GROUP BY M.mission_id, A.name
    HAVING A.name = 'CIA'
) AS Cia_Spies ON Cia_Spies.mission_id = All_Spies.mission_id
JOIN missions M ON All_Spies.mission_id = M.mission_id;