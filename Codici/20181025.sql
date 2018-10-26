SELECT ename, age
FROM Emp E, Works W, Dept D
WHERE E.eid = W.eid AND D.did = W.did AND D.dname = 'Hardware'
INTERSECT
SELECT ename, age
FROM Emp E, Works W, Dept D
WHERE E.eid = W.eid AND D.did = W.did AND D.dname = 'Software';

SELECT ename, age
FROM Emp E, Works W1, Works W2, Dept D1, Dept D2
WHERE (E.eid = W1.eid AND D1.did = W1.did AND D1.dname = 'Software') 
    AND (E.eid = W2.eid AND D2.did = W2.did AND D2.dname = 'Software');

SELECT did, COUNT(did)
FROM Works
GROUP BY did
HAVING sum(pct_time)> 20*100;

SELECT ename
FROM Emp E
WHERE salary > (
    SELECT MAX(D.budget)
    FROM Dept D NATURAL JOIN Works W  -- nelle subquery le tabelle esterne sono ancora visibili!
    WHERE E.eid = W.eid
);

SELECT ename
FROM Emp E
WHERE salary > ALL(
    SELECT D.budget
    FROM Dept D NATURAL JOIN Works W 
    WHERE E.eid = W.eid
);

SELECT D.managerid
FROM Dept D
GROUP BY managerid
HAVING MIN(budget) > 1000000;

SELECT E.ename
FROM Emp E JOIN Dept D ON managerid = eid
WHERE budget = (
    SELECT MAX(budget)
    FROM Dept D
);

SELECT managerid
FROM Dept D
GROUP BY managerid
HAVING SUM(budget) > 5000000;

SELECT managerid
FROM (
    SELECT managerid, SUM(budget) as cb
    FROM Dept
    GROUP BY managerid
) AS ControlM
WHERE cb =  (
    SELECT MAX(cb)
    FROM ControlM
);