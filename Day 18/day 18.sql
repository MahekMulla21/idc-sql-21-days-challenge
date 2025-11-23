use hospital_services;

SELECT name AS full_name FROM patients UNION SELECT staff_name AS full_name FROM staff;

SELECT patient_id, name, satisfaction, 'High' AS category FROM patients WHERE satisfaction > 90 UNION ALL
SELECT patient_id, name, satisfaction, 'Low' AS category FROM patients WHERE satisfaction < 50;

SELECT name AS full_name FROM patients UNION SELECT staff_name AS full_name FROM staff;

SELECT patient_id AS identifier, name AS full_name, 'Patient' AS type, service FROM patients WHERE service IN ('emergency', 'surgery')
UNION ALL
SELECT staff_id AS identifier, staff_name AS full_name, 'Staff' AS type, service FROM staff WHERE service IN ('emergency', 'surgery')
ORDER BY type, service, full_name;