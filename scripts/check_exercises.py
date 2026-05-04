import sqlite3

conn = sqlite3.connect('E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/build/backups/gym_log_proper.sqlite')
c = conn.cursor()

c.execute("SELECT name FROM sqlite_master WHERE type='table'")
print("Tables:", [r[0] for r in c.fetchall()])

c.execute("SELECT COUNT(*) FROM exercises")
print("Exercises count:", c.fetchone()[0])

c.execute("SELECT * FROM exercises LIMIT 1")
row = c.fetchone()
print("Columns:", [d[0] for d in c.description])
print("Sample row:", row)

c.execute("SELECT * FROM exercises")
all_ex = c.fetchall()
print(f"\nTotal exercises: {len(all_ex)}")

from collections import defaultdict

# By name
name_groups = defaultdict(list)
for ex in all_ex:
    name_groups[ex[2]].append(ex)  # name is index 2

dup_names = {k: v for k, v in name_groups.items() if len(v) > 1}
print(f"\n=== Duplicates by Name ({len(dup_names)} groups) ===")
for name, items in sorted(dup_names.items(), key=lambda x: -len(x[1])):
    print(f'\n"{name}" ({len(items)}):')
    for ex in items:
        print(f'  ID={ex[0]}, eid={ex[1] or "(null)"}, src={ex[23]}, cat={ex[24]}, eq={ex[26]}')

# By exercise_id
id_groups = defaultdict(list)
for ex in all_ex:
    if ex[1]:  # exercise_id
        id_groups[ex[1]].append(ex)

dup_ids = {k: v for k, v in id_groups.items() if len(v) > 1}
print(f"\n=== Duplicates by exercise_id ({len(dup_ids)} groups) ===")
for eid, items in sorted(dup_ids.items(), key=lambda x: -len(x[1])):
    print(f'\n{eid} ({len(items)}):')
    for ex in items:
        print(f'  ID={ex[0]}, name="{ex[2]}", src={ex[23]}')

conn.close()
