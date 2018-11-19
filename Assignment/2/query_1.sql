SELECT DISTINCT secret_agencies.name
FROM secret_agencies, operates
WHERE operates.country_id = serves_country_id
AND secret_agencies.id = operates.agency_id;