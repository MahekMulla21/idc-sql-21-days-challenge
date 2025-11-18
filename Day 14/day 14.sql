/*Question Create a staff utilisation report showing all staff members (staff_id, staff_name 
role, servcie) and the count of weeks they were present (from staff_shedule). Include staff 
members even if they have no shedule records . Order by weeks present descending. */

use hospital_services;

SELECT
	s.staff_id,
	s.staff_name,
	s.role,
	s.service,
COUNT(ss.week) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss
	ON s.staff_id = ss.staff_id
GROUP BY
	s.staff_id, s.staff_name, s.role, s.service
ORDER BY
weeks_present DESC;

ALTER TABLE staff
ALTER COLUMN total_occurence SET DEFAULT 0;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM staff WHERE staff_id = '0';
SET SQL_SAFE_UPDATES = 1;


INSERT INTO staff (staff_id, staff_name, role, service, weeks_present, total_occurence)  
VALUES  
('STF-5ca26577', 'Allison Hill', 'doctor', 'emergency', 0, 0),  
('STF-02ae59ca', 'Noah Rhodes', 'doctor', 'emergency', 0, 0),  
('STF-d8006e7c', 'Angie Henderson', 'doctor', 'emergency', 0, 0),  
('STF-212d8b31', 'Daniel Wagner', 'doctor', 'emergency', 0, 0),  
('STF-107a58e4', 'Cristian Santos', 'doctor', 'emergency', 0, 0),  
('STF-ca932dea', 'Connie Lawrence', 'nurse', 'emergency', 0, 0);

ALTER TABLE staff
DROP COLUMN event,
DROP COLUMN total_occurence;

SELECT * FROM staff;