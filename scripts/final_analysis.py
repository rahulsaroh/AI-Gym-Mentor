import json
from collections import defaultdict

with open('E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/assets/data/exercises.json', 'r', encoding='utf-8') as f:
    exercises = json.load(f)

print('=' * 70)
print('       DUPLICATE EXERCISE ANALYSIS - AI GYM MENTOR DATABASE')
print('=' * 70)
print(f'\nTotal exercises in JSON source: {len(exercises)}')
print(f'Source file: assets/data/exercises.json')

# 1. Exact name duplicates (case-sensitive)
name_groups = defaultdict(list)
for ex in exercises:
    name_groups[ex['name']].append(ex)

dup_names = {k: v for k, v in name_groups.items() if len(v) > 1}
total_exact = sum(len(v) for v in dup_names.values())

print(f'\n{"="*70}')
print('1. EXACT NAME DUPLICATES (Case-Sensitive)')
print('="*70}')
print(f'Groups with exact duplicate names: {len(dup_names)}')
print(f'Total affected entries: {total_exact}')
print('\nDetails:')
for name, items in sorted(dup_names.items(), key=lambda x: -len(x[1])):
    print(f'\n  "{name}" — {len(items)} duplicates:')
    for i in items:
        cats = f"{i.get('category','?')}/{i.get('equipment','?')}/{i.get('difficulty','?')}"
        print(f'    • ID: {i["id"]:20s} | Cat/Equip/Diff: {cats:40s}')
        if i.get('primaryMuscles'):
            print(f'      Primary muscles: {", ".join(i["primaryMuscles"][:3])}')

# 2. Case-insensitive name duplicates (excluding exact matches)
name_groups_ci = defaultdict(list)
for ex in exercises:
    name_groups_ci[ex['name'].lower().strip()].append(ex)

dup_names_ci = {k: v for k, v in name_groups_ci.items() if len(v) > 1}
total_ci = sum(len(v) for v in dup_names_ci.values())

# Only show those that differ in case
case_variants_only = {k: v for k, v in dup_names_ci.items() 
                      if len(set(i['name'] for i in v)) > 1}

print(f'\n{"="*70}')
print('2. CASE-INSENSITIVE DUPLICATES (Different Capitalization Only)')
print('="*70}')
print(f'Names with case variants: {len(case_variants_only)}')
print(f'Total affected entries: {sum(len(v) for v in case_variants_only.values())}')
print('\nDetails:')
for name, items in sorted(case_variants_only.items(), key=lambda x: -len(x[1])):
    name_variants = set(i['name'] for i in items)
    print(f'\n  "{name.title()}" — {len(items)} entries ({len(name_variants)} case variants):')
    print(f'    Names: {", ".join(sorted(name_variants))}')
    for i in items:
        print(f'    • ID: {i["id"]} (as "{i["name"]}")')

# 3. Full duplicates (name + category + equipment)
key_groups = defaultdict(list)
for ex in exercises:
    key = (ex['name'].lower().strip(),
           ex.get('category', '').lower().strip(),
           ex.get('equipment', '').lower().strip())
    key_groups[key].append(ex)

dup_keys = {k: v for k, v in key_groups.items() if len(v) > 1}
total_keys = sum(len(v) for v in dup_keys.values())

print(f'\n{"="*70}')
print('3. FULL DUPLICATES (Same Name + Category + Equipment)')
print('="*70}')
print(f'True duplicate groups: {len(dup_keys)}')
print(f'Total entries in these groups: {total_keys}')
print('\nDetailed List:')
for idx, ((name, cat, equip), items) in enumerate(sorted(dup_keys.items(), key=lambda x: -len(x[1])), 1):
    print(f'\n  {idx}. "{name}"')
    print(f'     Category: {cat} | Equipment: {equip}')
    print(f'     -> {len(items)} entries')
    for i in items:
        diff = i.get('difficulty', '?')
        muscles = ', '.join(i.get('primaryMuscles', [])[:3])
        print(f'       - {i["id"]:20s} (Difficulty: {diff}, Muscles: {muscles})')

# 4. Summary statistics
print(f'\n{"="*70}')
print('4. SUMMARY & RECOMMENDATIONS')
print('="*70}')
print(f'\nTotal exercises:                        {len(exercises)}')
print(f'Exact name duplicates (group count):     {len(dup_names)}')
print(f'Exact name duplicate entries:            {total_exact}')
print(f'Case variant duplicates (group count):   {len(case_variants_only)}')
print(f'Case variant duplicate entries:          {sum(len(v) for v in case_variants_only.values())}')
print(f'Full duplicates (name+cat+equip):        {len(dup_keys)}')
print(f'Full duplicate entries:                  {total_keys}')

print(f'\nRecommendations:')
print(f'  1. The {len(dup_names)} exact name duplicates should be investigated -')
print(f'     these are truly identical names and may indicate data quality issues.')
print(f'  2. The {len(case_variants_only)} case-variant groups should be normalized')
print(f'     to a consistent capitalization format.')
print(f'  3. The {len(dup_keys)} full duplicate groups (same name/category/equipment)')
print(f'     represent actual duplicate exercise entries with different IDs.')
print(f'     These should be merged or one removed.')

print(f'\nNote: The duplicate IDs (like "0088", "1371") appear to be from')
print(f'a different numbering scheme than the yuhonas_* IDs, suggesting')
print(f'these may have been imported from multiple sources.')
print('=' * 70)
