import pandas as pd
import json
import os
import re

def parse_excel():
    file_path = r'e:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\6 Day PPL.xlsx'
    sheet_name = 'Exercise Plan'
    
    if not os.path.exists(file_path):
        print(f"Error: File not found at {file_path}")
        return

    # Read the sheet
    df = pd.read_excel(file_path, sheet_name=sheet_name)
    
    program = {
        "name": "6 Day PPL",
        "description": "Imported from 6 Day PPL.xlsx",
        "days": []
    }
    
    current_day = None
    
    # Process rows
    for i, row in df.iterrows():
        val0 = str(row[0]).strip()
        
        # Identify a New Day / Section
        if "Day — Session Log" in val0:
            day_name = val0.replace("💪", "").replace("— Session Log", "").strip()
            current_day = {
                "name": day_name,
                "exercises": []
            }
            program["days"].append(current_day)
            continue
            
        if current_day is None:
            continue
            
        # Identify Metadata (Date, Week, etc.)
        if "Date:" in val0:
            # We skip metadata for templates, but could use for history if needed
            continue
            
        # Identify Exercises
        # Exercises usually have something in "Notes / Cues" or "Default Sets"
        # and they are not empty strings or NaN
        if val0 and val0 != 'nan' and not val0.startswith("Fill in:") and not val0.startswith("SESSION"):
            exercise_name = val0
            notes = str(row[1]) if pd.notna(row[1]) else ""
            default_sets = str(row[18]) if pd.notna(row[18]) else "3"
            default_reps = str(row[19]) if pd.notna(row[19]) else "10"
            
            # Extract logs for this exercise in this session
            logs = []
            # In this Excel format, weight and reps are in separate columns
            # Unnamed: 2 = Set 1 Weight, Unnamed: 3 = Set 1 Reps
            # Unnamed: 5 = Set 2 Weight, Unnamed: 6 = Set 2 Reps
            # ... and so on
            for s in range(5):
                weight_col = 2 + (s * 3)
                reps_col = 3 + (s * 3)
                if weight_col < len(row) and reps_col < len(row):
                    w = row[weight_col]
                    r = row[reps_col]
                    try:
                        # Try to clean and convert to float
                        if pd.notna(w) and pd.notna(r):
                            w_str = str(w).split('\n')[0].strip()
                            r_str = str(r).split('\n')[0].strip()
                            # Use regex to find first number
                            w_match = re.search(r"[-+]?\d*\.\d+|\d+", w_str)
                            r_match = re.search(r"[-+]?\d*\.\d+|\d+", r_str)
                            
                            if w_match and r_match:
                                logs.append({
                                    "set": s + 1,
                                    "weight": float(w_match.group()),
                                    "reps": float(r_match.group())
                                })
                    except (ValueError, TypeError):
                        continue
            
            current_day["exercises"].append({
                "name": exercise_name,
                "notes": notes,
                "defaultSets": default_sets,
                "defaultReps": default_reps,
                "logs": logs
            })

    # Generate JSON compatible with app's internal import system
    import_json = {
        "name": program["name"],
        "description": program["description"],
        "days": []
    }

    for day_idx, day in enumerate(program["days"]):
        day_exercises = []
        for ex_idx, ex in enumerate(day["exercises"]):
            # Format setsJson from logs or as default
            sets_data = []
            if ex["logs"]:
                for log in ex["logs"]:
                    sets_data.append({"reps": int(log["reps"]), "weight": float(log["weight"])})
            else:
                # Use default reps/sets if no logs
                reps_match = re.search(r"\d+", str(ex["defaultReps"]))
                reps = int(reps_match.group()) if reps_match else 10
                sets_count_match = re.search(r"\d+", str(ex["defaultSets"]))
                sets_count = int(sets_count_match.group()) if sets_count_match else 3
                for _ in range(sets_count):
                    sets_data.append({"reps": reps, "weight": 0.0})

            day_exercises.append({
                "exerciseName": ex["name"],
                "order": ex_idx,
                "setType": "normal",
                "setsJson": json.dumps(sets_data),
                "restTime": 90,
                "notes": ex["notes"]
            })
            
        import_json["days"].append({
            "name": day["name"],
            "order": day_idx,
            "exercises": day_exercises
        })

    json_output_path = r'e:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\assets\data\imported_ppl.json'
    with open(json_output_path, 'w', encoding='utf-8') as f:
        json.dump(import_json, f, indent=2, ensure_ascii=False)
        
    print(f"Successfully generated JSON to {json_output_path}")

if __name__ == "__main__":
    parse_excel()
