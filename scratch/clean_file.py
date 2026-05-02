import re

file_path = r'e:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\lib\features\workout\workout_screen.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

cleaned_lines = []
for line in lines:
    # Remove literal \n at the start of the line (after optional whitespace)
    # The view_file output showed "2: \nimport"
    # So we look for \n at the start of the content.
    cleaned_line = re.sub(r'^(\s*)\\n', r'\1', line)
    cleaned_lines.append(cleaned_line)

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(cleaned_lines)

print(f"Cleaned {len(cleaned_lines)} lines in {file_path}")
