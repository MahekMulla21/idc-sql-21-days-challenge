use hospital_services;

SELECT * FROM patients;
SELECT patient_id,  name, age FROM patients;
SELECT * FROM services_weekly 
LIMIT 10;

SELECT name AS patient_name, age AS paticent_age FROM patients;
SELECT DISTINCT(service)
FROM services_weekly;