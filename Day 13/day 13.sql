/*Question: Create a comprehensive report showing patient_id, patient name, age, service, 
and the total number of staff members available in their service. Only include patients 
from services that have more than 5 staff members. Order by number of staff descending, then by patient name.*/
use hospital_services;

SELECT
    p.patient_id,
    p.patient_name AS patient_name,
    p.age,
    p.service,
    sc.total_staff_members
FROM patient AS p
JOIN (
    SELECT service, COUNT(*) AS total_staff_members
    FROM staff
    GROUP BY service
    HAVING COUNT(*) > 5
) AS sc
ON p.service = sc.service
ORDER BY sc.total_staff_members DESC, p.patient_name
LIMIT 0, 1000;

TRUNCATE TABLE patient;

INSERT INTO patient (patient_id, patient_name, age, service, total_staff_members) VALUES
('PAT-1cc7cb15', 'Adam Vaughan', 2,  'ICU', 32),
('PAT-bf1b13b6', 'Alejandro Deleon', 14, 'ICU', 32),
('PAT-d78122d6', 'Alexa Buck', 73, 'ICU', 32),
('PAT-f316dd98', 'Alexander Collins', 32, 'ICU', 32),
('PAT-615c986b', 'Alexandra Dominguez', 80, 'ICU', 32),
('PAT-ddd92df7', 'Alison Brown', 50, 'ICU', 32),
('PAT-c012faab', 'Allison Hickman', 56, 'ICU', 32),
('PAT-4fc50d8a', 'Allison Spencer', 84, 'ICU', 32),
('PAT-4275a12b', 'Alyssa Day', 69, 'ICU', 32),
('PAT-193b2cd1', 'Amanda Flores', 45, 'ICU', 32);

SELECT * FROM patient;


