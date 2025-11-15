## Daily Challenge:
use hospital_services;
/* Question:** Analyze the event impact by comparing weeks with events vs weeks without events.
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending. */

INSERT INTO services_weekly 
(event, week, service, Patients_Admitted, Patients_Refused, Admission_Rate_Percentage, patient_satisfaction, staff_morale)
VALUES
(NULL, 32, 'General', 75, 2, 97.40, 78, 72),
(NULL, 33, 'Medical', 88, 3, 96.70, 79, 74),
(NULL, 34, 'Nutrition', 70, 2, 97.22, 77, 73),
(NULL, 35, 'Wellness', 65, 1, 98.48, 80, 75),
(NULL, 36, 'Dental', 82, 3, 96.47, 78, 74),

(NULL, 37, 'Community', 68, 2, 97.14, 76, 72),
(NULL, 38, 'Eye Care', 72, 1, 98.63, 77, 73),
(NULL, 39, 'General', 90, 4, 95.74, 79, 74),
(NULL, 40, 'Medical', 84, 2, 97.67, 78, 73),
(NULL, 41, 'Awareness', 65, 1, 98.48, 77, 72),

(NULL, 42, 'Wellness', 70, 2, 97.22, 80, 75),
(NULL, 43, 'Eye Care', 69, 2, 97.18, 76, 73),
(NULL, 44, 'Nutrition', 71, 3, 95.94, 77, 74),
(NULL, 45, 'General', 88, 4, 95.65, 79, 75),
(NULL, 46, 'Medical', 85, 2, 97.70, 78, 74),

(NULL, 47, 'Community', 73, 2, 97.33, 77, 73),
(NULL, 48, 'Dental', 80, 3, 96.39, 78, 74),
(NULL, 49, 'Wellness', 67, 1, 98.52, 79, 75),
(NULL, 50, 'Nutrition', 72, 2, 97.30, 77, 73),
(NULL, 51, 'General', 91, 4, 95.80, 78, 74);



SELECT
    CASE
        WHEN event IS NOT NULL AND LOWER(event) <> 'none'
            THEN 'With Event'
        ELSE 'No Event'
    END AS event_status,
    COUNT(DISTINCT week) AS week_count,
    AVG(patient_satisfaction) AS avg_patient_satisfaction,
    AVG(staff_morale) AS avg_staff_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_patient_satisfaction DESC;

