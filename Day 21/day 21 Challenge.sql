use Hospital_services;

/* 1. Create a CTE to calculate service statistics, then query from it.*/

WITH service_stats_cte AS (
    SELECT 
        service,
         SUM(patients_request) AS total_patients_request,
        SUM(patients_admitted) AS total_patients_admitted,
        SUM(patients_refused) AS total_patients_refused,
        ROUND(AVG(patient_satisfaction), 2) AS average_patient_satisfcation
    FROM services_weekly
    GROUP BY service
)
SELECT * FROM service_stats_cte;

-- 2. Use multiple CTEs to break down a complex query into logical steps.

INSERT INTO service_rates (service, admission_rate, refusion_rate, ranking)
VALUES
('General', 75, 5, 1),
('Medical', 80, 10, 2),
('Wellness', 65, 8, 3),
('Emergency', 90, 3, 4),
('Nutrition', 70, 7, 5),
('General_Machine', 60, 12, 6),
('Eye Care', 85, 4, 7),
('Dental', 78, 6, 8),
('Awareness', 68, 9, 9);


WITH service_stats_cte AS (
    SELECT 
        service,
        SUM(patients_request) AS total_patients_request,
        SUM(patients_admitted) AS total_patients_admitted,
        SUM(patients_refused) AS total_patients_refused,
        ROUND(AVG(patient_satisfaction), 2) AS average_patient_satisfaction
    FROM services_weekly
    GROUP BY service
),
cte_rates AS (
    SELECT 
        service,
        ROUND(total_patients_admitted / total_patients_request, 2) AS admission_rate,
        ROUND(total_patients_refused / total_patients_request, 2) AS refusion_rate,
        RANK() OVER (ORDER BY total_patients_admitted DESC) AS ranking
    FROM service_stats_cte
)
SELECT *
FROM service_rates;

-- 3. Build a CTE for staff utilization and join it with patient data

WITH staff_cte AS (
    SELECT service,
           COUNT(staff_id) AS total_staff
    FROM staff
    GROUP BY service
),
patient_cte AS (
    SELECT service,
           COUNT(patient_id) AS total_patients,
           ROUND(AVG(satisfaction), 2) AS average_satisfaction
    FROM patients
    GROUP BY service
)
SELECT s.service, s.total_staff, p.total_patients, p.average_satisfaction
FROM staff_cte s
JOIN patient_cte p
ON s.service = p.service
ORDER BY s.service;
SELECT *
FROM service_summary;

INSERT INTO service_summary(service, total_staff, total_patients, average_satisfaction)
VALUES
('general', 50, 30, 4.5),
('machine', 40, 25, 4.2),
('surgery', 35, 20, 4.8),
('emergency', 63, 19, 4.0),
('ICU', 20, 15, 4.7);


/*Question: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level setrics (total admissions, refusals, ang satisfaction),
2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a
final report showing service name, all calculated metrics, and an overall performance score (welighted average of admission rate and satisfaction). 
Order by performance score descending*/


WITH service_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        ROUND(AVG(patient_satisfaction), 2) AS avg_pt_satisfaction,
        ROUND(
            CASE WHEN (SUM(patients_admitted) + SUM(patients_refused)) = 0 THEN 0
                 ELSE SUM(patients_admitted) * 100.0 /
                      (SUM(patients_admitted) + SUM(patients_refused))
            END
        , 2) AS admission_rate
    FROM services_weekly
    GROUP BY service
),
staff_weeks AS (
    SELECT
        st.staff_id,
        st.service,
        COUNT(*) AS weeks_present   
    FROM staff st
    LEFT JOIN staff_schedule sch
        ON st.staff_id = sch.staff_id
    GROUP BY st.staff_id, st.service
),
staff_metrics AS (
    SELECT
        service,
        COUNT(DISTINCT staff_id) AS total_staff,
        ROUND(AVG(weeks_present), 2) AS avg_weeks_present
    FROM staff_weeks
    GROUP BY service
),
patient_demographics AS (
    SELECT
        service,
        COUNT(*) AS total_patients,
        ROUND(AVG(age), 2) AS average_age
    FROM patients
    GROUP BY service
)
SELECT
    sm.service,
    sm.total_admissions,
    sm.total_refusals,
    sm.avg_pt_satisfaction,
    sm.admission_rate,
    COALESCE(stm.total_staff, 0)        AS total_staff,
    COALESCE(stm.avg_weeks_present, 0)  AS avg_weeks_present,
    COALESCE(pd.total_patients, 0)      AS total_patients,
    COALESCE(pd.average_age, 0)         AS average_age,
    ROUND(
       (COALESCE(sm.admission_rate, 0) * 0.5) +
       (COALESCE(sm.avg_pt_satisfaction, 0) * 20 * 0.5)
    , 2) AS overall_performance_score
FROM service_metrics sm
LEFT JOIN staff_metrics stm ON sm.service = stm.service
LEFT JOIN patient_demographics pd ON sm.service = pd.service
ORDER BY overall_performance_score DESC;


