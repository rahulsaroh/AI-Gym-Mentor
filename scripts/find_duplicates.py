import sqlite3
import os
import json

# Find the database file
db_paths = [
    r'E:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\dev\archive\data\gym_log.sqlite',
    r'E:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\build\backups\gym_log_20260428_143259.sqlite',
    r'E:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\build\backups\gym_log_20260428_143412.sqlite',
]

db_path = None
for p in db_paths:
    if os.path.exists(p):
        db_path = p
        break

if not db_path:
    print("No database found")
    exit(1)

print(f"Using database: {db_path}\n")
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Get all exercises
cursor.execute("SELECT * FROM exercises ORDER BY name")
exercises = cursor.fetchall()
col_names = [desc[0] for desc in cursor.description]

print(f"=== Duplicate Exercise Analysis ===")
print(f"Total exercises: {len(exercises)}\n")

# Group by name
from collections import defaultdict
name_groups = defaultdict(list)
for ex in exercises:
    name = ex[col_names.index('name')]
    name_groups[name].append(ex)

# Find duplicates by name
dup_names = {k: v for k, v in name_groups.items() if len(v) > 1}
print(f"--- Duplicates by Name ({len(dup_names)} groups) ---\n")
total_name_dups = 0
for name, items in sorted(dup_names.items(), key=lambda x: -len(x[1])):
    total_name_dups += len(items)
    print(f'Name: "{name}" ({len(items)} duplicates)')
    for ex in items:
        eid = ex[col_names.index('exercise_id')]
        source = ex[col_names.index('source')]
        cat = ex[col_names.index('category')]
        equip = ex[col_names.index('equipment')]
        did = ex[col_names.index('id')]
        print(f'  - DB ID: {did}, exercise_id: {eid or "(null)"}, source: {source}, category: {cat}, equipment: {equip}')
    print()

# Group by exercise_id
id_groups = defaultdict(list)
for ex in exercises:
    eid = ex[col_names.index('exercise_id')]
    if eid:
        id_groups[eid].append(ex)

dup_ids = {k: v for k, v in id_groups.items() if len(v) > 1}
print(f"--- Duplicates by exercise_id ({len(dup_ids)} groups) ---\n")
total_id_dups = 0
for eid, items in sorted(dup_ids.items(), key=lambda x: -len(x[1])):
    total_id_dups += len(items)
    print(f'ID: "{eid}" ({len(items)} duplicates)')
    for ex in items:
        name = ex[col_names.index('name')]
        source = ex[col_names.index('source')]
        did = ex[col_names.index('id')]
        print(f'  - DB ID: {did}, name: "{name}", source: {source}')
    print()

# Group by name+category+equipment
key_groups = defaultdict(list)
for ex in exercises:
    name = ex[col_names.index('name')].lower()
    cat = ex[col_names.index('category')].lower()
    equip = ex[col_names.index('equipment')].lower()
    key = f"{name}|{cat}|{equip}"
    key_groups[key].append(ex)

dup_keys = {k: v for k, v in key_groups.items() if len(v) > 1}
print(f"--- Duplicates by Name+Category+Equipment ({len(dup_keys)} groups) ---\n")
total_key_dups = 0
for key, items in sorted(dup_keys.items(), key=lambda x: -len(x[1])):
    total_key_dups += len(items)
    name, cat, equip = key.split('|')
    print(f'Key: "{name}" | "{cat}" | "{equip}" ({len(items)} duplicates)')
    for ex in items:
        did = ex[col_names.index('id')]
        eid = ex[col_names.index('exercise_id') or "(null)"]
        diff = ex[col_names.index('difficulty')]
        print(f'  - ID: {did}, exercise_id: {eid}, difficulty: {diff}')
    print()

print("=== Summary ===")
print(f"Total exercises: {len(exercises)}")
print(f"Exercises with duplicate names: {total_name_dups} (in {len(dup_names)} groups)")
print(f"Exercises with duplicate exercise_id: {total_id_dups} (in {len(dup_ids)} groups)")
print(f"Exercises with duplicate name+cat+equip: {total_key_dups} (in {len(dup_keys)} groups)")

# Count by source
source_counts = defaultdict(int)
for ex in exercises:
    source = ex[col_names.index('source')]
    source_counts[source] += 1
print(f"\n--- By Source ---")
for src, cnt in sorted(source_counts.items()):
    print(f"  {src}: {cnt}")

# Unique names
unique_names = len(set(ex[col_names.index('name')].lower() for ex in exercises))
print(f"\nUnique names (case-insensitive): {unique_names}")
print(f"Unique exercise_ids: {len(id_groups)}")

# List all exercises for reference
print(f"\n=== All Exercises (sorted by name) ===")
for ex in sorted(exercises, key=lambda x: x[col_names.index('name')].lower()):
    did = ex[col_names.index('id')]
    name = ex[col_names.index('name')]
    eid = ex[col_names.index('exercise_id')] or "(null)"
    source = ex[col_names.index('source')]
    cat = ex[col_names.index('category')]
    equip = ex[col_names.index('equipment')]
    diff = ex[col_names.index('difficulty')]
    print(f"ID {did:3d} | name={name:30s} | eid={eid:30s} | src={source:5s} | cat={cat:10s} | equip={equip:10s} | diff={diff}")

conn.close()
