import sqlite3

# Try different databases to find one that works
dbs = [
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/dev/archive/data/gym_log.sqlite',
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_20260428_143259.sqlite',
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_20260428_143412.sqlite',
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_proper.sqlite',
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_clean.sqlite',
    'E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_clean2.sqlite',
    'E:/db_fixed.sqlite',
]

for db in dbs:
    try:
        conn = sqlite3.connect(db)
        c = conn.cursor()
        c.execute("SELECT name FROM sqlite_master WHERE type='table'")
        tables = c.fetchall()
        if tables:
            print(f"\n=== {db} === WORKS ===")
            print("Tables:", [t[0] for t in tables])
            for t, in tables:
                c.execute(f'SELECT COUNT(*) FROM "{t}"')
                cnt = c.fetchone()[0]
                print(f"  {t}: {cnt}")
        conn.close()
    except Exception as e:
        pass

print("\nDone")
