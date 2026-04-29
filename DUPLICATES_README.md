# Duplicate Exercise Analysis - README

## Overview
This directory contains analysis tools and reports for identifying duplicate exercises in the AI Gym Mentor database.

## Quick Start

```bash
# Run the main analysis
python scripts/find_exercise_duplicates.py

# Or use the detailed report generator
python scripts/final_analysis.py
```

## Analysis Results

### Summary
- **Total exercises**: 2,197
- **Exact name duplicates**: 6 groups, 12 entries (0.55%)
- **Case-insensitive duplicates**: 112 groups, 225 entries (10.24%)
- **Full duplicates** (name+category+equipment): 6 groups, 12 entries

### Duplicate Groups (Exact Names)

| Exercise | IDs | Category | Equipment |
|---|---|---|---|
| barbell seated calf raise | 0088, 1371 | lower legs | barbell |
| ez barbell spider curl | 0454, 1628 | upper arms | ez barbell |
| lever chest press | 0577, 0576 | chest | leverage machine |
| push-up (on stability ball) | 0655, 0656 | chest | stability ball |
| self assisted inverse leg curl | 0697, 1766 | upper legs | body weight |
| smith reverse calf raises | 0763, 1394 | lower legs | smith machine |

### Case-Insensitive Duplicates

112 groups where the same exercise appears with different capitalization:
- `Barbell Curl` vs `barbell curl` (yuhonas_Barbell_Curl vs 0031)
- `Barbell Deadlift` vs `barbell deadlift` (yuhonas_Barbell_Deadlift vs 0032)
- `3/4 Sit-Up` vs `3/4 sit-up` (yuhonas_3_4_Sit-Up vs 0001)
- ... and 109 more

## Root Cause

Two data sources were merged:
1. **yuhonas dataset**: Uses `yuhonas_*` ID format
2. **Numeric dataset**: Uses `0001-3194` ID format

Both datasets contain the same exercises, with some entries having different capitalization.

## Files

### Analysis Scripts
- `scripts/find_exercise_duplicates.py` - Main analysis script (recommended)
- `scripts/final_analysis.py` - Detailed report with full listings
- `scripts/analyze_exercises.py` - Basic grouping analysis

### Reports
- `DUPLICATE_EXERCISES_REPORT.md` - Full detailed report with tables
- `ANALYSIS_SUMMARY.md` - Executive summary

### Cleanup Utilities
- `lib/utils/remove_duplicates.dart` - Dart utility for removing duplicates

### Data Sources
- `assets/data/exercises.json` - Source exercise data (2,197 entries)
- `lib/core/database/database.dart` - Database schema
- `lib/features/exercise_database/data/datasources/exercise_db_seeder.dart` - Database seeding

## Recommendations

### Priority 1: Remove Exact Duplicates
Delete numeric-ID entries when a yuhonas_* version exists:
- 0088 → keep yuhonas_Barbell_Seated_Calf_Raise
- 0454 → keep yuhonas_N/A (no yuhonas version, both numeric)
- ... etc

### Priority 2: Normalize Case
Convert all exercise names to Title Case:
- "barbell curl" → "Barbell Curl"
- "3/4 sit-up" → "3/4 Sit-Up"
- Standardize across all 112 case-variant groups

### Priority 3: Prevent Future Duplicates
1. Add database uniqueness constraint on `(name, category, equipment)`
2. Enhance seeder to detect and merge duplicates during import
3. Standardize on Title Case naming convention
4. Add validation in exercise creation/import flows

### Priority 4: Data Migration
If duplicates are removed from the database:
1. Update any foreign key references in related tables
2. Migrate workout history to use canonical IDs
3. Test thoroughly before deploying to production

## Database Schema

```sql
-- Main exercises table
CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    exercise_id TEXT UNIQUE,  -- External ID (yuhonas_* or numeric)
    name TEXT NOT NULL,
    category TEXT DEFAULT 'Strength',
    equipment TEXT NOT NULL,
    -- ... other fields
);

-- FTS5 virtual table for search
CREATE VIRTUAL TABLE exercises_fts USING fts5(
    id UNINDEXED,
    name,
    category,
    equipment,
    primary_muscle,
    content='exercises'
);

-- Related tables
CREATE TABLE exercise_muscles (exercise_id INT, muscle_name TEXT);
CREATE TABLE exercise_body_parts (exercise_id INT, body_part TEXT);
CREATE TABLE recent_exercises (exercise_id INT, viewed_at DATETIME);
```

## Usage Examples

### Python Analysis
```bash
cd /path/to/ai-gym-mentor
python scripts/find_exercise_duplicates.py
```

### Dart Database Cleanup
```dart
import 'package:ai_gym_mentor/utils/remove_duplicates.dart';

final result = await removeDuplicateExercises();
print('Removed: ${result['removed']} duplicates');
print('Normalized: ${result['normalized']} names');
```

## Testing

Before applying changes to production:
1. Backup the database
2. Test cleanup on development/staging
3. Verify no workout history is lost
4. Check all references are updated correctly
5. Run full test suite

## See Also

- [Database Migration History](lib/core/database/database.dart#L355-590)
- [Exercise Seeder](lib/features/exercise_database/data/datasources/exercise_db_seeder.dart)
- [Duplicate Content Migration](lib/core/database/database.dart#L509-521)

---

*Last analyzed: 2026-04-28*
*Total exercises in source: 2,197*

