use hospital_services;



SELECT
p.patient_id,
p.name,
p.service,
sw.week,
sw.patient_satisfaction
FROM patients p
JOIN services_weekly sw
ON p.service = sw.service
WHERE sw.service IN (
SELECT service
FROM services_weekly
GROUP BY service
HAVING
MAX(patients_refused) > 0
AND AVG(patient_satisfaction) < (
SELECT AVG(patient_satisfaction)
FROM services_weekly
)
);

INSERT INTO patients (name, service)
VALUES
('Amit Sharma', 'Cardiology'),
('Priya Kamat', 'Orthopedics'),
('Rohit Desai', 'Cardiology'),
('Neha Patil', 'Dermatology'),
('Karan Singh', 'Orthopedics'),
('Sneha More', 'Neurology');

INSERT INTO services_weekly
(service, week, patients_refused, patient_satisfaction, patients_admitted, admission_rate_percentage, available_beds)
VALUES
('Cardiology', '2025-W01', 5, 3.8, 42, 89.36, 10),
('Cardiology', '2025-W02', 2, 4.1, 38, 95.00, 12),
('Orthopedics', '2025-W01', 3, 3.5, 30, 90.91, 15),
('Orthopedics', '2025-W02', 0, 4.4, 35, 100.00, 14),
('Dermatology', '2025-W01', 0, 4.8, 22, 100.00, 8),
('Dermatology', '2025-W02', 1, 4.2, 25, 96.15, 9),
('Neurology', '2025-W01', 2, 3.2, 18, 90.00, 7),
('Neurology', '2025-W02', 0, 3.6, 20, 100.00, 6);

SHOW CREATE TABLE patients ;


