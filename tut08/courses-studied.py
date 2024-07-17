import sys
import psycopg2

conn = None
if len(sys.argv) < 3:
    print("Usage: ./courses-studied studentID term")
    exit(1)

student_id = sys.argv[1]
term = sys.argv[2]

# TODO: query for all of the courses that a student studied at a given term
COURSES_STUDIED_QUERY = """
SELECT
    course_code,
    course_name
FROM
    students_courses
WHERE
    student_id = %s
    AND term = %s
ORDER BY
    course_code
"""

try:
    conn = psycopg2.connect(f"dbname=uni")
    cur = conn.cursor()
    cur.execute(COURSES_STUDIED_QUERY, [student_id, term])
    courses = cur.fetchall()
    if len(courses) == 0:
        print("No courses found")
        exit(0)
    for course in courses:
        course_code = course[0]
        course_name = course[1]
        print(f"{course_code} {course_name}")
except psycopg2.Error as err:
    print("database error: ", err)
finally:
    if conn is not None:
        conn.close()
