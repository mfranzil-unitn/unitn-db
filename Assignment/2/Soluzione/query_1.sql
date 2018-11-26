-- 1. Find the agencies that operate in the countries which they serve.
--  For each such agency, return its name.
SELECT name
FROM secret_agencies
JOIN operates ON id=agency_id
WHERE serves_country_id=country_id
