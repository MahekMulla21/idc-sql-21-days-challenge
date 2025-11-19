-- DAY 15 (Multiple Joins)
-- Practice questions
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability

USE hospital_services;

SELECT 
    p.name AS patient_name,
    p.service,
    st.staff_name,
    st.role,
    sch.week,
    sch.staff_present
FROM patients p
JOIN staff st
    ON p.service = st.service
JOIN staff_schedule sch
    ON st.staff_name = sch.staff_name
ORDER BY p.name
LIMIT 0, 1000;

TRUNCATE TABLE patients;
INSERT INTO patients (patient_id, name, service) VALUES
(1, 'Mark Brown', 'emergency'),
(2, 'Joseph Cooper', 'emergency'),
(3, 'Nicole Phillips', 'emergency'),
(4, 'Shawn Scott', 'emergency'),
(5, 'Matthew Davis MD', 'emergency'),
(6, 'Holly Scott', 'emergency'),
(7, 'Michael Young', 'emergency'),
(8, 'James Chapman', 'emergency'),
(9, 'Robert Torres', 'emergency'),
(10, 'Lisa Perry', 'emergency'),
(11, 'Melissa Bishop', 'emergency');

ALTER TABLE staff_schedule
MODIFY staff_id VARCHAR(10);
UPDATE staff_schedule
SET staff_id = NULL
WHERE staff_id = '';
UPDATE staff_schedule
SET staff_id = NULL
WHERE staff_id = '' AND week > 0;
ALTER TABLE staff_schedule
MODIFY staff_id INT NULL;

INSERT INTO staff_schedule (staff_name, week, staff_present, total_staff_presence)
VALUES ('Allison Hill', 1, 1, 1);

SELECT * FROM staff_schedule;
SELECT * FROM patients;
SELECT * FROM staff;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.

SELECT 
  w.week, 
  w.service, 
  w.available_beds, 
  w.patients_admitted, 
  w.patient_satisfaction, 
  w.staff_morale,
  st.staff_name, 
  st.staff_id, 
  st.role, 
  sch.staff_present
FROM services_weekly w
JOIN staff st ON w.service = st.service
JOIN staff_schedule sch ON st.staff_name = sch.staff_name
LIMIT 0, 1000;


ALTER TABLE services_weekly
MODIFY COLUMN Patients_Refused INT NULL;

INSERT INTO staff_schedule (staff_name, staff_id, week, staff_present, total_staff_presence)
VALUES
('Allison Hill', 101, 1, 1, 1),
('Mark Johnson', 102, 2, 1, 1),
('Sarah White', 103, 3, 0, 0),
('Kevin Smith', 104, 4, 1, 1),
('Emily Brown', 105, 5, 1, 1),
('Daniel Clark', 106, 6, 0, 0),
('Rachel Green', 107, 7, 1, 1);

ALTER TABLE staff_schedule
MODIFY total_staff_presence INT DEFAULT 0;

INSERT INTO staff (staff_name, staff_id, service, role)
VALUES
('Allison Hill', 101, 'emergency', 'doctor'),
('Mark Johnson', 102, 'emergency', 'nurse'),
('Sarah White', 103, 'emergency', 'doctor'),
('Kevin Smith', 104, 'emergency', 'assistant'),
('Emily Brown', 105, 'emergency', 'nurse'),
('Daniel Clark', 106, 'emergency', 'doctor'),
('Rachel Green', 107, 'emergency', 'support staff');

INSERT INTO staff_schedule (staff_name, staff_id, week, staff_present)
VALUES
('Allison Hill', 101, 1, 1),
('Mark Johnson', 102, 2, 1),
('Sarah White', 103, 3, 0),
('Kevin Smith', 104, 4, 1),
('Emily Brown', 105, 5, 1),
('Daniel Clark', 106, 6, 0),
('Rachel Green', 107, 7, 1);

SELECT * FROM services_weekly;
SELECT * FROM staff;
SELECT * FROM staff_schedule;

SELECT * FROM services_weekly;
SELECT * 
FROM services_weekly
WHERE week IS NULL 
   OR patient_satisfaction IS NULL
   OR staff_morale IS NULL;
UPDATE services_weekly
SET 
    week = COALESCE(week, 1),
    patient_satisfaction = COALESCE(patient_satisfaction, 80),
    staff_morale = COALESCE(staff_morale, 75);
SELECT * FROM services_weekly;

-- 3. Create a multi-table report showing patient admissions with staff information.

SELECT 
    p.service, 
    p.patient_id, 
    p.name AS patient_name, 
    p.age AS patient_age, 
    p.arrival_date AS patient_admission_date,
    st.staff_id, 
    st.staff_name, 
    st.role, 
    sch.week, 
    sch.staff_present
FROM patients p
JOIN staff st
    ON p.service = st.service
JOIN staff_schedule sch
    ON st.staff_name = sch.staff_name
ORDER BY p.service
LIMIT 0, 1000;


INSERT INTO patients (name, age, arrival_date, service)
VALUES
('John Doe', 34, '2025-01-05', 'emergency'),
('Aisha Khan', 45, '2025-01-06', 'cardiology'),
('Rohan Patel', 29, '2025-01-07', 'orthopedics'),
('Maria Silva', 52, '2025-01-08', 'emergency'),
('Priya Sharma', 38, '2025-01-09', 'neurology'),
('David Kim', 41, '2025-01-10', 'cardiology'),
('Sara Lopez', 27, '2025-01-11', 'orthopedics');

/*Question: Create a comprehensive service analysis report for week 20 showing: 
service name, total patients admitted that week, total patients refused, average 
patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.*/

SELECT 
    w.service,
    SUM(w.patients_admitted) AS total_patients_admitted,
    SUM(w.patients_refused) AS total_patients_refused,
    ROUND(AVG(w.patient_satisfaction), 2) AS average_patient_satisfaction,
    COUNT(DISTINCT sch.staff_name) AS staff_assigned_to_service,
    SUM(sch.staff_present) AS staff_present
FROM services_weekly w
JOIN staff st 
    ON w.service = st.service      -- join staff to services
JOIN staff_schedule sch
    ON st.staff_name = sch.staff_name
    AND w.week = sch.week
WHERE w.week < 20
GROUP BY w.service
ORDER BY total_patients_admitted DESC;







