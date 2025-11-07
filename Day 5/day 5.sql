-- Count, SUM, SVG, MIN, MAX, Functions
use hospital_services;

-- 1. Count the total number of patients in the hospital.

SELECT COUNT(DISTINCT patient_id) AS total_patients
FROM patients;

-- 2. Calculate the average satisfaction score of all patients.

SELECT 
	ROUND(AVG(satisfaction),2) AS avg_satisfaction_score
FROM patients;

-- 3. Find the minimum and maximum age of patients.

SELECT 
	MIN(age) AS minimum_age,
    MAX(age) AS maximum_age
FROM patients;

-- Calculate the total number of patients admitted

SELECT  
  SUM(patients_admitted) AS total_patients_admitted,
  SUM(patients_refused) AS total_patients_refused,
  ROUND(AVG(patients_satisfaction), 2) AS avg_patient_satisfaction
FROM services_weekly;

-- 1) Create database (if not exists) and switch to it
CREATE DATABASE IF NOT EXISTS hospital_services;
USE hospital_services;

-- 2) Remove any old table to avoid conflicts (safe for a test environment)
DROP TABLE IF EXISTS services_weekly;

-- 3) Create a clean table with correct column names
CREATE TABLE services_weekly (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  service_name VARCHAR(100) NOT NULL,
  patients_admitted INT NOT NULL DEFAULT 0,
  patients_refused INT NOT NULL DEFAULT 0,
  patients_satisfaction DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  patients_request_count INT NULL
);

-- 4) Insert sample data (you can replace these with your real rows)
INSERT INTO services_weekly (service_name, patients_admitted, patients_refused, patients_satisfaction, patients_request_count) VALUES
('Cardiology', 40, 3, 9.20, 10),
('Neurology', 35, 5, 8.70, 12),
('Orthopedics', 50, 4, 9.00, 8),
('Pediatrics', 30, 2, 9.10, 5),
('Emergency', 75, 10, 8.50, 20);

-- 5) Optional: verify the table structure and data
DESC services_weekly;
SELECT * FROM services_weekly LIMIT 100;

/*calculate the total number of patients admitted, total patients refused, 
and the average patient satisfaction across all services and round the average satisfaction to 2 decimal places*/


SELECT
  SUM(patients_admitted)        AS total_patients_admitted,
  SUM(patients_refused)        AS total_patients_refused,
  ROUND(AVG(patients_satisfaction), 2) AS avg_patient_satisfaction
FROM services_weekly;



