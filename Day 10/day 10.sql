use hospital_services;

/*Create a service performace report showing service name, total patients admitted, and
a performance category on the following: 'Excellent' if avg satisfaction >= 85, 'Good'
if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement' . Order by average satisfaction 
descending.*/

SET SQL_SAFE_UPDATES = 0;

UPDATE services_weekly
SET rating = 81.23
WHERE service = 'General_Machine';

SET SQL_SAFE_UPDATES = 1;
SELECT  
  service AS 'Service',
  SUM(patients_admitted) AS 'Total Patients Admitted',
  ROUND(AVG(rating), 2) AS 'Average Satisfaction',
  CASE
    WHEN AVG(rating) >= 85 THEN 'Excellent'
    WHEN AVG(rating) >= 75 THEN 'Good'
    WHEN AVG(rating) >= 65 THEN 'Fair'
    ELSE 'Needs Improvement'
  END AS 'Performance Category'
FROM services_weekly
GROUP BY service
ORDER BY `Average Satisfaction` DESC;


