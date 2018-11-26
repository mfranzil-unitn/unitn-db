-- 5. Find the missions in which both the spy with name 007 and the spy
--  with name 008 participated. For each such mission,
-- list its name and the primary and secondary targets.

SELECT codename, primary_target, secondary_target
FROM missions m
JOIN works_on w1 ON m.mission_id=w1.mission_id
JOIN works_on w2 ON m.mission_id=w2.mission_id
JOIN spies s1 ON w1.spy_id=s1.id AND s1.name='007'
JOIN spies s2 ON w2.spy_id=s2.id AND s2.name='008'
