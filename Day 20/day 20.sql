use hospital_services;


SELECT
service,
week,
patients_admitted,
SUM(patients_admitted) OVER(
PARTITION BY service
ORDER BY week
) AS cumulative_patients_admitted,
ROUND (AVG(patient_satisfaction) OVER(
PARTITION BY service
ORDER BY week
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
), 2) AS satisfaction_moving_average_3weeks,
ROUND(patients_admitted - AVG(patients_admitted) OVER(
PARTITION BY service
), 2) AS diff_from_service_avg
FROM (
SELECT *
FROM services_weekly
WHERE week BETWEEN 10 AND 20
) t
ORDER BY service, week;