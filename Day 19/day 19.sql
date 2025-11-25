use hospital_services;


SELECT *
FROM (
SELECT
service,
week,
patient_satisfaction,
patients_admitted,
RANK() OVER (
PARTITION BY service
ORDER BY patient_satisfaction DESC
) AS rank_patient_sats
FROM services_weekly
) ranked
WHERE rank_patient_sats <3
ORDER BY service, rank_patient_sats;