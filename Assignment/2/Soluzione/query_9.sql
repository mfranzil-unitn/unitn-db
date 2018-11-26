-- 9. Find all the countries in which:
--  (a) there is a pending mission, and
--  (b) In this pending mission the spy with the nickname ’Mr. Big’ participates.
--  For each such country, return its name.

SELECT DISTINCT name
FROM countries c
JOIN legs l ON c.id=l.country_id
JOIN missions m ON l.mission_id=m.mission_id AND NOT completed
JOIN works_on wo ON m.mission_id=wo.mission_id
JOIN nicknames n ON wo.spy_id=n.spy_id AND nickname='Mr. Big'
