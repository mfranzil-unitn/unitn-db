-- 2. Find the agencies that operate in any three distinct countries
--  that pairwise border each other. For each such agency return its name,
--  and the names of the three bordering countries ordered alphabetically (a→z).

SELECT sa.name, c1.name, c2.name, c3.name
FROM secret_agencies sa
-- Restrice countries to "operates"
JOIN operates o1 ON sa.id=o1.agency_id
JOIN operates o2 ON sa.id=o2.agency_id
JOIN operates o3 ON sa.id=o3.agency_id
-- Triangle
JOIN borders b1 ON o1.country_id=b1.country_id1
JOIN borders b2 ON o2.country_id=b2.country_id1 AND
    b1.country_id2 = b2.country_id1 AND b1.country_id1 <> b2.country_id2
JOIN borders b3 ON o3.country_id=b3.country_id1 AND
    b2.country_id2 = b3.country_id1 AND b3.country_id2 = b1.country_id1
-- Attribute sorting (c1 < c2 < c3)
JOIN countries c1 ON o1.country_id=c1.id
JOIN countries c2 ON o2.country_id=c2.id AND
    c1.name < c2.name
JOIN countries c3 ON o3.country_id=c3.id AND
    c2.name < c3.name
