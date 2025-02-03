USE clubs_management;

SELECT COUNT(*)
FROM event_participants
WHERE event_id = (
	SELECT id FROM events WHERE club_id = 3 ORDER BY event_date DESC LIMIT 1
);

SELECT id FROM events WHERE club_id = 3;

SELECT event_id, event_date, COUNT(*) AS participant_count
FROM event_participants AS ep
INNER JOIN events AS e
ON ep.event_id = e.id
WHERE event_id IN (
	SELECT id FROM events WHERE club_id = 3
)
GROUP BY event_id
ORDER BY participant_count DESC
LIMIT 1;

SELECT AVG(participant_count)
FROM (
    SELECT event_id, COUNT(*) AS participant_count
    FROM event_participants
    WHERE event_id IN (
        SELECT id FROM events WHERE club_id = 3
    )
    GROUP BY event_id
) AS event_counts;


SELECT s.class, COUNT(*) AS class_count
FROM event_participants AS ep
INNER JOIN events AS e ON ep.event_id = e.id
INNER JOIN students AS s ON ep.student_id = s.id
WHERE event_id IN (
	SELECT id FROM events WHERE club_id = 3
)
GROUP BY s.class
ORDER BY class_count DESC
LIMIT 1;

SELECT 100 * unique_parts.unique_participants/total_students.total_count AS popularity
FROM (
	SELECT 
		COUNT(DISTINCT ep.student_id) AS unique_participants
	FROM 
		clubs AS c
	INNER JOIN 
		events AS e ON e.club_id = c.id
	INNER JOIN 
		event_participants AS ep ON ep.event_id = e.id
	WHERE 
		c.id = 3
) AS unique_parts
CROSS JOIN (
	SELECT COUNT(*) AS total_count
	FROM students
) AS total_students;

SELECT c.name, COUNT(*) AS club_participations
FROM clubs as c
INNER JOIN events as e ON e.club_id = c.id
INNER JOIN event_participants as ep ON ep.event_id = e.id
GROUP BY c.name;

SELECT popularity
FROM (
	SELECT 
		club_parts.id,
		club_parts.name, 
		club_parts.club_participations, 
		100 * club_parts.club_participations / total_participations.total_count AS popularity
	FROM (
		SELECT 
			c.id,
			c.name, 
			COUNT(*) AS club_participations
		FROM 
			clubs AS c
		INNER JOIN 
			events AS e ON e.club_id = c.id
		INNER JOIN 
			event_participants AS ep ON ep.event_id = e.id
		GROUP BY 
			c.name
	) AS club_parts
	CROSS JOIN (
		SELECT COUNT(*) AS total_count
		FROM event_participants
	) AS total_participations
) AS club_ps
WHERE club_ps.id = 3;



SELECT *
FROM (
	SELECT e.event_date, et.name, COUNT(*) AS participants_count
	FROM event_participants AS ep
	INNER JOIN events AS e ON ep.event_id = e.id
	INNER JOIN clubs AS c ON e.club_id = c.id
    INNER JOIN event_types AS et ON e.event_type_id = et.id
	WHERE c.id = 3
	GROUP BY e.id
	ORDER BY e.event_date DESC
	LIMIT 7
) AS e
ORDER BY e.event_date ASC;
-- ORDER BY e.id, participants_count

SELECT event_date
FROM events
WHERE club_id = 3;

SELECT et.name, COUNT(*) AS participants_count
FROM event_participants AS ep
INNER JOIN events AS e ON ep.event_id = e.id
INNER JOIN clubs AS c ON e.club_id = c.id
INNER JOIN event_types AS et ON e.event_type_id = et.id
WHERE c.id = 3 AND e.event_date = "2024-09-15"
GROUP BY e.id
ORDER BY e.event_date DESC;


SELECT s.class, COUNT(*) AS participants_count
FROM event_participants AS ep
INNER JOIN events AS e ON ep.event_id = e.id
INNER JOIN clubs AS c ON e.club_id = c.id
INNER JOIN event_types AS et ON e.event_type_id = et.id
INNER JOIN students AS s ON s.id = ep.student_id
WHERE c.id = 3 AND e.event_date = "2024-09-15"
GROUP BY s.class
ORDER BY participants_count DESC;
-- LIMIT 1


SELECT class, 100*participants_count/class_students AS proportion
FROM (
	SELECT *
    FROM (
		SELECT s.class, COUNT(*) AS participants_count
		FROM event_participants AS ep
		INNER JOIN events AS e ON ep.event_id = e.id
		INNER JOIN clubs AS c ON e.club_id = c.id
		INNER JOIN event_types AS et ON e.event_type_id = et.id
		INNER JOIN students AS s ON s.id = ep.student_id
		WHERE c.id = 3 AND e.event_date = "2024-09-15"
		GROUP BY s.class
		ORDER BY participants_count DESC
    ) AS cc
    INNER JOIN (
		SELECT s.class AS sclass, COUNT(*) AS class_students
        FROM students AS s
        GROUP BY s.class
    ) AS ce
    WHERE ce.sclass = cc.class
) AS globals
ORDER BY proportion DESC
LIMIT 1;





