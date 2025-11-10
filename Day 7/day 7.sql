use hospital_services;

SELECT 
    service,
    total_no_of_patients_refused,
    avg_patient_satisfaction
FROM service_weekly
WHERE 
    total_no_of_patients_refused > 100
    AND avg_patient_satisfaction < 80
LIMIT 0, 1000;
