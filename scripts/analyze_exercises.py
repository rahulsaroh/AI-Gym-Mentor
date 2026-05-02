import json
from collections import defaultdict

with open('E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/assets/data/exercises.json', 'r', encoding='utf-8') as f:
    exercises = json.load(f)

print('Total exercises:', len(exercises))

# Group by name
name_groups = defaultdict(list)
for ex in exercises:
    name_groups[ex['name']].append(ex)

dup_names = {k: v for k, v in name_groups.items() if len(v) > 1}
print('Names with duplicates (case-sensitive):', len(dup_names))
total_d = sum(len(v) for v in dup_names.values())
print('Total duplicate name entries:', total_d)

print('\n=== Top 20 Duplicate Names (case-sensitive) ===')
for name, items in sorted(dup_names.items(), key=lambda x: -len(x[1]))[:20]:
    print(f'  "{name}" ({len(items)}):', ', '.join(i['id'] for i in items))

# Group by name (case-insensitive)
name_groups_ci = defaultdict(list)
for ex in exercises:
    name_groups_ci[ex['name'].lower().strip()].append(ex)

dup_names_ci = {k: v for k, v in name_groups_ci.items() if len(v) > 1}
print(f'\nNames with duplicates (case-insensitive):', len(dup_names_ci))
total_ci = sum(len(v) for v in dup_names_ci.values())
print('Total duplicate entries (case-insensitive):', total_ci)

print('\n=== Duplicate Names (case-insensitive, excluding exact matches) ===')
for name, items in sorted(dup_names_ci.items(), key=lambda x: -len(x[1]))[:30]:
    # Check if all have same case
    names_set = set(i['name'] for i in items)
    if len(names_set) > 1:
        print(f'  "{name}" ({len(items)}) - case variants: {names_set}')
        print(f'    IDs: {", ".join(i["id"] for i in items)}')

# Group by name + category + equipment
key_groups = defaultdict(list)
for ex in exercises:
    key = (ex['name'].lower().strip(), 
           ex.get('category', '').lower().strip(),
           ex.get('equipment', '').lower().strip())
    key_groups[key].append(ex)

dup_keys = {k: v for k, v in key_groups.items() if len(v) > 1}
print(f'\n=== Duplicates by Name+Category+Equipment (case-insensitive): {len(dup_keys)} groups ===')
total_key = sum(len(v) for v in dup_keys.values())
print(f'Total: {total_key}')
for (name, cat, equip), items in sorted(dup_keys.items(), key=lambda x: -len(x[1]))[:30]:
    print(f'  "{name}" | "{cat}" | "{equip}" ({len(items)})')
    for i in items:
        print(f'    - {i["id"]} (diff: {i.get("difficulty", "?")})')