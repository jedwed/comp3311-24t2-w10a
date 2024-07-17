import sys
import psycopg2

conn = None
if len(sys.argv) < 2:
    print("Usage: opendb DBname")
    exit(1)

try:
    conn = psycopg2.connect(f"dbname=uni")
    cur = conn.cursor()
except psycopg2.Error as err:
    print("database error: ", err)
finally:
    if conn is not None:
        conn.close()
