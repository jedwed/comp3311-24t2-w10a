
CREATE OR REPLACE VIEW students_courses (
    student_id,
    family,
    given,
    course_code,
    course_name,
    term
) AS 
    SELECT
        stu.id,
        p.family,
        p.given,
        s.code,
        s.name,
        t.code
    FROM 
        subjects AS s
    JOIN
        courses AS c
        ON s.id = c.subject
    JOIN
        course_enrolments AS ce
        ON c.id = ce.course
    JOIN
        students AS stu
        ON ce.student = stu.id
    JOIN
        people AS p
        ON stu.id = p.id
    JOIN
        terms AS t
        ON c.term = t.id
