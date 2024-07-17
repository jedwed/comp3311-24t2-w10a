import sys
import psycopg2

conn = None
if len(sys.argv) < 2:
    print("Usage: python3 nsubjects.py {subject}")
    exit(1)

school_pattern = sys.argv[1]

SUBJECT_COUNT_QUERY = """
SELECT
    o.longname,
    COUNT(*)
FROM
    subjects AS s
JOIN
    orgunits AS o
    ON s.offeredby = o.id
WHERE
    o.longname ~* %s    
GROUP BY 
    o.longname
"""


try:
    conn = psycopg2.connect(f"dbname=uni")
    cur = conn.cursor()
    cur.execute(SUBJECT_COUNT_QUERY, [school_pattern])
    schools = cur.fetchall()
    if len(schools) == 1:
        school_name, count = schools[0]
        print(f"{school_name} teaches {count} subjects")
    elif len(schools) > 1:
        print("Multiple schools match")
        for school in schools:
            print(school[0])

except psycopg2.Error as err:
    print("database error: ", err)
finally:
    if conn is not None:
        conn.close()
