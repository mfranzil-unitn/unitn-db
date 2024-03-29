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