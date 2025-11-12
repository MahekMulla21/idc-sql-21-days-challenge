use hospital_services;

/*Calculate the average length of stay (in days) for each service, 
showing only services where the average stay is more than 7 days.
Also show the count of patients and order by average stay descending*/


SELECT service,
ROUND(AVG(datediff(departure_date, arrival_date)), 2) AS average_stay,
COUNT(patient_id) AS 'Total patients'
FROM patients
GROUP BY service
HAVING average_stay > 7
ORDER BY average_stay DESC;



CREATE TABLE patient_summary (
    service VARCHAR(50),
    average_stay DECIMAL(5,2),
    `Total patients` INT
);

INSERT INTO patient_summary (service, average_stay, `Total patients`)
VALUES
('surgery', 7.87, 254),
('ICU', 7.61, 241),
('emergency', 7.16, 263);

SELECT * FROM patient_summary;


