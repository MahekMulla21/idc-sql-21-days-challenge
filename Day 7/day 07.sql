use hospital_services;

-- 1. Find services that have admitted more than 500 patients in total
SELECT 
    service,
    SUM(patients_admitted) AS total_no_of_patients_admitted
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted) > 500;

-- 2. Show services where average patients satisfaction in below 75

SELECT 
    service,
    AVG(patient_satisfaction) AS patient_satisfaction
FROM service_week
GROUP BY service
HAVING AVG(patient_satisfaction) < 75;

-- 3. List weeks where total presence across all services was less than 50.

SELECT 
    week,
    service,
    SUM(staff_present) AS total_staff_presence
FROM staff_schedule
GROUP BY week, service
HAVING SUM(staff_present) < 50
ORDER BY week, service;


INSERT INTO staff_schedule (week, service, staff_present, total_staff_presence)
VALUES 
  (12, 'General_Medicine', 42, 42),
  (12, 'Surgery', 38, 38),
  (13, 'Emergency', 49, 49),
  (14, 'ICU', 47, 47),
  (15, 'Pediatrics', 36, 36)
ON DUPLICATE KEY UPDATE
  staff_present = VALUES(staff_present),
  total_staff_presence = VALUES(total_staff_presence);

  
ALTER TABLE staff_schedule DROP PRIMARY KEY;
ALTER TABLE staff_schedule ADD PRIMARY KEY (week, service);





  