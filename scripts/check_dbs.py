import sqlite3
import os

db_paths = [
    r'E:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\build\backups\gym_log_20260428_143259.sqlite',
    r'E:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\build\backups\gym_log_20260428_143412.sqlite',
]

for db_path in db_paths:
    if not os.path.exists(db_path):
        print(f"Skip: {db_path} - not found")
        continue
    print(f"\n=== {db_path} ===")
    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = c.fetchall()
    print(f"Tables: {[t[0] for t in tables]}")
    
    for table_name, in tables:
        c.execute(f"SELECT COUNT(*) FROM {table_name}")
        count = c.fetchone()[0]
        print(f"  {table_name}: {count} rows")
        
        if table_name == 'exercises':
            c.execute("SELECT * FROM exercises ORDER BY name LIMIT 5")
            rows = c.fetchall()
            cols = [desc[0] for desc in c.description]
            print(f"    Columns: {cols}")
            for row in rows:
                print(f"    {row}")
    
    conn.close()
