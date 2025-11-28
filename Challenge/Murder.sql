use Murder;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    role VARCHAR(100)
);
CREATE TABLE keycard_logs (
    log_id INT PRIMARY KEY,
    employee_id INT,
    room VARCHAR(100),
    entry_time DATETIME,
    exit_time DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
CREATE TABLE calls (
    call_id INT PRIMARY KEY,
    caller_id INT,
    receiver_id INT,
    call_time DATETIME,
    duration_sec INT,
    FOREIGN KEY (caller_id) REFERENCES employees(employee_id),
    FOREIGN KEY (receiver_id) REFERENCES employees(employee_id)
);
CREATE TABLE alibis (
    alibi_id INT PRIMARY KEY,
    employee_id INT,
    claimed_location VARCHAR(200),
    claim_time DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
CREATE TABLE evidence (
    evidence_id INT PRIMARY KEY,
    room VARCHAR(100),
    description VARCHAR(500),
    found_time DATETIME
);
INSERT INTO employees VALUES
(1, 'John Mathew', 'IT', 'Engineer'),
(2, 'Sarah Lee', 'Finance', 'Analyst'),
(3, 'Priya Singh', 'Operations', 'Manager'),
(4, 'David Kumar', 'Security', 'Officer'),
(5, 'Amit Shah', 'Admin', 'Clerk');

INSERT INTO keycard_logs VALUES
(101, 4, 'CEO Office', '2025-10-15 20:10:00', '2025-10-15 20:45:00'),
(102, 2, 'Lobby', '2025-10-15 20:05:00', '2025-10-15 20:10:00'),
(103, 3, 'Meeting Room', '2025-10-15 20:20:00', '2025-10-15 20:55:00'),
(104, 1, 'Cafeteria', '2025-10-15 20:30:00', '2025-10-15 20:50:00'),
(105, 4, 'CEO Office', '2025-10-15 20:50:00', '2025-10-15 21:00:00');

INSERT INTO calls VALUES
(201, 4, 3, '2025-10-15 20:52:00', 65),
(202, 1, 2, '2025-10-15 18:30:00', 120),
(203, 3, 5, '2025-10-15 20:40:00', 80);

INSERT INTO alibis VALUES
(301, 4, 'Home', '2025-10-15 20:30:00'),
(302, 2, 'Gym', '2025-10-15 20:15:00'),
(303, 1, 'Cafeteria', '2025-10-15 20:40:00');

INSERT INTO evidence VALUES
(401, 'CEO Office', 'Fingerprint on desk', '2025-10-15 21:10:00'),
(402, 'CEO Office', 'Security badge found', '2025-10-15 21:12:00');


SELECT 
    k.log_id,
    e.name,
    k.entry_time,
    k.exit_time
FROM keycard_logs k
JOIN employees e ON k.employee_id = e.employee_id
WHERE room = 'CEO Office'
AND entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00';




SELECT 
    a.employee_id,
    e.name,
    a.claimed_location,
    a.claim_time,
    k.room,
    k.entry_time
FROM alibis a
JOIN employees e ON a.employee_id = e.employee_id
JOIN keycard_logs k ON a.employee_id = k.employee_id
WHERE DATE(a.claim_time) = '2025-10-15'
  AND a.claim_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00';
  
  
 SELECT 
    c.call_id,
    e1.name AS caller,
    e2.name AS receiver,
    c.call_time,
    c.duration_sec
FROM calls c
JOIN employees e1 ON c.caller_id = e1.employee_id
JOIN employees e2 ON c.receiver_id = e2.employee_id
WHERE c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';



SELECT *
FROM evidence
WHERE room = 'CEO Office';



WITH suspects AS (
    SELECT 
        k.employee_id,
        e.name,
        k.entry_time,
        k.exit_time
    FROM keycard_logs k
    JOIN employees e ON k.employee_id = e.employee_id
    WHERE k.room = 'CEO Office'
      AND k.entry_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
),
false_alibis AS (
    SELECT a.employee_id
    FROM alibis a
    JOIN keycard_logs k ON a.employee_id = k.employee_id
    WHERE a.claim_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
),
late_calls AS (
    SELECT caller_id AS employee_id
    FROM calls 
    WHERE call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00'
)
SELECT DISTINCT s.employee_id, s.name
FROM suspects s
LEFT JOIN false_alibis f ON s.employee_id = f.employee_id
LEFT JOIN late_calls l ON s.employee_id = l.employee_id
WHERE f.employee_id IS NOT NULL
  AND l.employee_id IS NOT NULL;




