use hospital_services;

# 1. List all unique services in the patients table.
SELECT DISTINCT service FROM patients;

# 2. Find all unique staff roles in the hosptial.
SELECT DISTINCT role FROM staff;

# 3. Get distinct months from the services_weekly table.
SELECT DISTINCT month FROM services_weekly;

SELECT 
	service,
    event,
    COUNT(*) AS total_occurance
FROM service_week
WHERE event is not null
AND LOWER(event) <> 'none'
GROUP BY service, event
ORDER BY total_occurence DESC;


  
CREATE TABLE service_events_summary (
    service VARCHAR(100),
    event_type VARCHAR(100),
    event_count INT
);
INSERT INTO service_events_summary (service, event_type, event_count) VALUES
('general_medicine', 'flu', 6),
('ICU', 'flu', 5),
('emergency', 'flu', 5),
('surgery', 'donation', 5),
('surgery', 'strike', 4);
SELECT * 
FROM service_events_summary
ORDER BY event_count DESC;


    