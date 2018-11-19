SELECT W.agency_id
FROM works W
JOIN spies S on W.spy_id = S.id
JOIN secret_agencies A ON A.id = W.agency_id
WHERE (A.serves_country_id, S.country_id) IN (
    SELECT *
    FROM borders
)
GROUP BY W.agency_id, S.country_id
HAVING COUNT(*) > ALL (
    SELECT COUNT(*)
    FROM works W1
    JOIN spies S1 ON W1.spy_id = S1.id
    WHERE W1.agency_id = W.agency_id
    AND S1.country_id != S.country_id
    GROUP BY S1.country_id
)
ORDER BY agency_id ASC;