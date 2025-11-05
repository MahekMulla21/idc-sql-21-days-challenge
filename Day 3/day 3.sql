-- ORDER BY, ASC/ DESC, multiple column sorting
USE hospital_services;

SELECT 
  week,
  service,
  patients_refused,
  patients_request
FROM services_weekly
ORDER BY patients_refused DESC
LIMIT 0, 1000;



INSERT INTO services_weekly (week, service, patients_refused, patients_request)
VALUES
(1, 'General Medicine', 5, 40),
(2, 'Surgery', 3, 25),
(3, 'Orthopedics', 7, 32),
(4, 'Pediatrics', 2, 28),
(5, 'Cardiology', 4, 20);




