USE hospital_services;

-- Correct the spelling
SET SQL_SAFE_UPDATES = 0;
UPDATE patients 
SET service = 'general_medicine' 
WHERE service = 'general_machine';
SET SQL_SAFE_UPDATES = 1;

-- Remove null entries if they exist
SET SQL_SAFE_UPDATES = 0;
DELETE FROM patients 
WHERE service IS NULL;
SET SQL_SAFE_UPDATES = 1;

SELECT DISTINCT service 
FROM patients;
ALTER TABLE patients
CHANGE COLUMN id patient_id VARCHAR(30);

DESCRIBE patients;
SELECT 
 patient_id, 
 name, 
 age, 
 satisfaction 
FROM patients 
WHERE 
service = 'surgery' AND satisfaction < 70

