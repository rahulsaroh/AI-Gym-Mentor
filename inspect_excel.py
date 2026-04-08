import pandas as pd
import json
import os

def inspect():
    file_path = r'e:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\6 Day PPL.xlsx'
    sheet_name = 'Exercise Plan'
    
    try:
        if not os.path.exists(file_path):
            print(f"Error: File not found at {file_path}")
            return
            
        df = pd.read_excel(file_path, sheet_name=sheet_name)
        
        # Get basic info
        info = {
            "columns": df.columns.tolist(),
            "head": df.head(100).to_dict(orient='records'),
            "sheets": pd.ExcelFile(file_path).sheet_names
        }
        
        output_path = r'e:\Rahul\Softwares\AI Gym Mentor\AI Gym Mentor\excel_inspection.json'
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(info, f, indent=2, ensure_ascii=False)
            
        print(f"Inspection successful. Saved to {output_path}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    inspect()
