import sqlite3

conn = sqlite3.connect('E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_proper.sqlite')
conn.execute("PRAGMA writable_schema = 1")
conn.execute("PRAGMA ignore_check_constraints = 1")
conn.execute("PRAGMA journal_mode = OFF")
conn.execute("PRAGMA synchronous = OFF")
conn.execute("PRAGMA foreign_keys = OFF")

c = conn.cursor()

try:
    c.execute("SELECT name FROM sqlite_master WHERE type='table'")
    print("Tables:", [r[0] for r in c.fetchall()])
except Exception as e:
    print("Error reading tables:", e)
    # Try to salvage what we can
    c.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name='exercises'")
    sql = c.fetchone()
    print("Exercises table SQL:", sql)
    if sql:
        c.execute("CREATE TABLE IF NOT EXISTS exercises_new AS SELECT * FROM exercises")
        c.execute("SELECT COUNT(*) FROM exercises_new")
        print("Count:", c.fetchone()[0])

conn.close()
print("Done")
