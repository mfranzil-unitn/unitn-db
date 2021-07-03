-- Data to create the database:

CREATE TABLE Emp (
    eid SERIAL NOT NULL PRIMARY KEY,
    ename TEXT,
    age INTEGER,
    salary REAL
);

CREATE TABLE Dept(
    did SERIAL NOT NULL PRIMARY KEY,
    dname TEXT,
    budget REAL,
    managerid SERIAL,
    FOREIGN KEY(managerid) REFERENCES Emp(eid)
);

CREATE TABLE Works(
    eid SERIAL,
    did SERIAL,
    pct_time INTEGER,
    FOREIGN KEY(eid) REFERENCES Emp,
    FOREIGN KEY(did) REFERENCES Dept,
    PRIMARY KEY(eid, did)
);