CREATE TABLE countries (
    id          INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    population  INTEGER NOT NULL);

CREATE TABLE borders (
    country_id1 INTEGER REFERENCES countries,
    country_id2 INTEGER REFERENCES countries,
    PRIMARY KEY (country_id1, country_id2));

CREATE TABLE secret_agencies (
    id                  INTEGER PRIMARY KEY,
    name                TEXT NOT NULL,
    serves_country_id   INTEGER REFERENCES countries  NOT NULL);

CREATE TABLE operates (
    agency_id   INTEGER REFERENCES secret_agencies,
    country_id  INTEGER REFERENCES countries,
    PRIMARY KEY (agency_id, country_id));

CREATE TABLE spies(
    id          INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    country_id  INTEGER REFERENCES countries NOT NULL,
    good_guy    BOOLEAN NOT NULL DEFAULT TRUE);

CREATE TABLE nicknames (
    spy_id      INTEGER REFERENCES spies,
    nickname    TEXT,
    PRIMARY KEY(spy_id, nickname));

CREATE TABLE works (
    spy_id      INTEGER REFERENCES spies,
    agency_id   INTEGER REFERENCES secret_agencies,
    PRIMARY KEY(spy_id, agency_id));

CREATE TABLE missions (
    mission_id              INTEGER PRIMARY KEY,
    codename                TEXT NOT NULL,
    primary_target          TEXT NOT NULL,
    secondary_target        TEXT NOT NULL,
    duration                INTEGER NOT NULL,
    supervised_agency_id    INTEGER REFERENCES secret_agencies NOT NULL,
    completed               BOOLEAN NOT NULL DEFAULT FALSE);

CREATE TABLE legs (
    mission_id  INTEGER REFERENCES missions,
    legno       INTEGER,
    country_id  INTEGER REFERENCES countries NOT NULL,
    PRIMARY KEY (mission_id, legno));

CREATE TABLE works_on (
    spy_id      INTEGER REFERENCES spies,
    mission_id  INTEGER REFERENCES missions,
    grade       INTEGER NOT NULL,
    PRIMARY KEY (spy_id, mission_id));
