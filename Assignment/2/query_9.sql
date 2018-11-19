SELECT DISTINCT C.name
FROM missions M
JOIN works_on WO ON M.mission_id = WO.mission_id
JOIN spies S on S.id = WO.spy_id
JOIN nicknames N on S.id = N.spy_id
JOIN legs L on L.mission_id = M.mission_id
JOIN countries C on L.country_id = C.id
WHERE M.completed = FALSE AND N.nickname = 'Mr. Big';