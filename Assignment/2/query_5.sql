SELECT M.codename,
       M.primary_target,
       M.secondary_target
FROM works_on W1 
JOIN works_on W2 ON W1.mission_id = W2.mission_id
JOIN spies S1 ON W1.spy_id = S1.id
JOIN spies S2 ON W2.spy_id = S2.id
JOIN missions M ON W1.mission_id = M.mission_id
WHERE S1.name = '007' AND S2.name = '008';