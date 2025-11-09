use hospital_services;


select
	service,
    SUM(patients_admitted) AS Patients_Admitted,
    SUM(patients_refused) AS Patients_Refused,
    ROUND(
			(SUM(patients_admitted) * 100.0) /
            (SUM(patients_admitted) + SUM(patients_refused)), 2
		) AS Admission_Rate_Percentage
	FROM
		services_weekly
	GROUP BY
		service
	ORDER BY
		Admission_Rate_Percentage DESC;


INSERT INTO services_weekly (service, patients_admitted, patients_refused, admission_rate_percentage)
VALUES
('ICU', 120, 5, ROUND((120*100.0)/(120+5), 2)),
('Surgery', 150, 10, ROUND((150*100.0)/(150+10), 2)),
('General_Machine', 180, 20, ROUND((180*100.0)/(180+20), 2)),
('Emergency', 200, 15, ROUND((200*100.0)/(200+15), 2));

SELECT * FROM services_weekly;

