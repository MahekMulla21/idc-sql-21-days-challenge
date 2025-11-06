USE hospital_services;

SELECT 
patient_id,
name,
age,
satisfaction
FROM patients
WHERE
service = "surgery" AND satisfaction < 70;

-- Find the 3rd to 7th highest patient satisfaction scores

SELECT 
	Patient_id, name, service, satifaction
FROM patients
ORDER BY satifaction DESC
LIMIT 5
OFFSET 2;



