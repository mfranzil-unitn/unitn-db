-- 1

SELECT DISTINCT secret_agencies.name
FROM secret_agencies, operates
WHERE operates.country_id = serves_country_id
AND secret_agencies.id = operates.agency_id;

-- 2

SELECT DISTINCT aa.name AS agency_name,
                cc1.name AS first_state,
                cc2.name AS second_state,
                cc3.name AS third_state
FROM (
    SELECT DISTINCT c1, c2, c3, MoreThanThree.agency_id
    FROM (
        SELECT DISTINCT 
            B1.country_id1 AS c1,
            B2.country_id1 AS c2,
            B3.country_id1 AS c3
        FROM borders B1 
        JOIN borders B2 ON B1.country_id1 = B2.country_id2 
        JOIN borders B3 ON B2.country_id1 = B3.country_id2 
        AND B3.country_id1 = B1.country_id2
        )
    AS Bordering, (
        SELECT DISTINCT A.id AS agency_id
        FROM secret_agencies A 
        JOIN operates O ON A.id = O.agency_id
        GROUP BY A.id
        HAVING COUNT(*) > 2
    ) 
    AS MoreThanThree, operates O1, operates O2, operates O3
    WHERE c1 = O1.country_id
    AND c2 = O2.country_id
    AND c3 = O3.country_id
    AND MoreThanThree.agency_id = O1.agency_id
    AND MoreThanThree.agency_id = O2.agency_id
    AND MoreThanThree.agency_id = O3.agency_id
    )
AS Tuples 
JOIN countries cc1 ON c1 = cc1.id
JOIN countries cc2 ON c2 = cc2.id
JOIN countries cc3 ON c3 = cc3.id
JOIN secret_agencies aa ON Tuples.agency_id = aa.id
WHERE cc1.name < cc2.name AND cc2.name < cc3.name;

-- 3

SELECT A.name
FROM works W
JOIN spies S on W.spy_id = S.id
JOIN secret_agencies A ON A.id = W.agency_id
WHERE (A.serves_country_id, S.country_id) IN (
    SELECT *
    FROM borders
)
GROUP BY W.agency_id, S.country_id, A.name
HAVING COUNT(*) > ALL (
    SELECT COUNT(*)
    FROM works W1
    JOIN spies S1 ON W1.spy_id = S1.id
    WHERE W1.agency_id = W.agency_id
    AND S1.country_id != S.country_id
    GROUP BY S1.country_id
)
ORDER BY agency_id ASC;

-- 4

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

-- 5 

SELECT M.codename,
       M.primary_target,
       M.secondary_target
FROM works_on W1 
JOIN works_on W2 ON W1.mission_id = W2.mission_id
JOIN spies S1 ON W1.spy_id = S1.id
JOIN spies S2 ON W2.spy_id = S2.id
JOIN missions M ON W1.mission_id = M.mission_id
WHERE S1.name = '007' AND S2.name = '008';

-- 6

SELECT M1.codename
FROM missions M1
WHERE M1.duration = (
    SELECT M.duration
    FROM missions M
    GROUP BY M.duration
    ORDER BY M.duration DESC
    LIMIT 1 OFFSET 1
);

-- 7

SELECT Tab.mission_id, M.codename
FROM (
    SELECT L.mission_id as mission_id
    FROM legs L
    GROUP BY L.mission_id
    HAVING COUNT(*) >= 1 
    AND COUNT(*) = COUNT(DISTINCT L.country_id)
) AS Tab
INNER JOIN missions M on Tab.mission_id = M.mission_id;

-- 8

SELECT M.codename,
       COALESCE(
           ROUND(
               cia_count::NUMERIC / spy_count::NUMERIC,
               2
            ), 0.00
        ) AS percentage
FROM (
    SELECT M.mission_id AS mission_id,
           COUNT(*) AS spy_count
    FROM missions M
    JOIN works_on WO on M.mission_id = WO.mission_id
    JOIN works W ON WO.spy_id = W.spy_id
    JOIN secret_agencies A on W.agency_id = A.id
    GROUP BY M.mission_id
) AS All_Spies
FULL OUTER JOIN (
    SELECT M.mission_id AS mission_id,
           COUNT(*) AS cia_count
    FROM missions M
    JOIN works_on WO on M.mission_id = WO.mission_id
    JOIN works W ON WO.spy_id = W.spy_id
    JOIN secret_agencies A on W.agency_id = A.id
    WHERE A.name = 'CIA'
    GROUP BY M.mission_id
) AS CIA_Spies ON All_Spies.mission_id = CIA_Spies.mission_id
INNER JOIN missions M on All_Spies.mission_id = M.mission_id;

-- 9

SELECT DISTINCT C.name
FROM missions M
JOIN works_on WO ON M.mission_id = WO.mission_id
JOIN spies S on S.id = WO.spy_id
JOIN nicknames N on S.id = N.spy_id
JOIN legs L on L.mission_id = M.mission_id
JOIN countries C on L.country_id = C.id
WHERE M.completed = FALSE AND N.nickname = 'Mr. Big';

-- 10

SELECT C.name, COUNT(DISTINCT L.mission_id)
FROM countries C 
JOIN legs L ON C.id = L.country_id 
GROUP BY C.id;