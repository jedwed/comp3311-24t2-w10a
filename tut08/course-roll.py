import sys
import psycopg2

conn = None
if len(sys.argv) < 3:
    print("Usage: python3 course-roll.py subject term")
    exit(1)

subject = sys.argv[1]
term = sys.argv[2]

SUBJECT_QUERY = """
SELECT
    *
FROM
    subjects
WHERE
    code = %s
"""

STUDENTS_QUERY = """
SELECT
    student_id,
    family,
    given
FROM
    students_courses
WHERE
    course_code = %s
    AND term = %s
ORDER BY
    family,
    given
"""

try:
    conn = psycopg2.connect(f"dbname=uni")
    cur = conn.cursor()

    cur.execute(SUBJECT_QUERY, (subject,))
    if cur.fetchone() is None:
        print(f"Invalid subject {subject}")
        exit(0)

    # TODO: Check if the given term is invalid

    print(f"{subject} {term}")
    cur.execute(STUDENTS_QUERY, (subject, term))
    students = cur.fetchall()
    if len(students) == 0:
        print("No offering")
    for student_id, family, given in students:
        print(f"{student_id} {family}, {given}")
except psycopg2.Error as err:
    print("database error: ", err)
finally:
    if conn is not None:
        conn.close()
