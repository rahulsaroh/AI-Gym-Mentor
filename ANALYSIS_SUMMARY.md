# Duplicate Exercises Analysis - Complete Summary

## Overview
Analyzed the AI Gym Mentor exercise database (source: `assets/data/exercises.json`)
containing **2,197 exercises** for duplicate entries.

## Findings

### 1. Exact Name Duplicates (6 groups, 12 entries)
True duplicates with identical names:
- barbell seated calf raise (0088, 1371)
- ez barbell spider curl (0454, 1628)
- lever chest press (0577, 0576)
- push-up (on stability ball) (0655, 0656)
- self assisted inverse leg curl (0697, 1766)
- smith reverse calf raises (0763, 1394)

### 2. Case-Insensitive Duplicates (112 groups, 225 entries)
Same exercise with different capitalization:
- Barbell Curl vs barbell curl (yuhonas_Barbell_Curl vs 0031)
- Barbell Deadlift vs barbell deadlift (yuhonas_Barbell_Deadlift vs 0032)
- 3/4 Sit-Up vs 3/4 sit-up (yuhonas_3_4_Sit-Up vs 0001)
- 112 total case variants, all following the pattern: yuhonas_* vs numeric ID

### 3. Full Duplicates (6 groups, 12 entries)
Identical name + category + equipment:
- See section 1 (all exact name duplicates are also full duplicates)

## Root Cause
Two data sources were merged:
1. **yuhonas dataset**: Uses `yuhonas_*` IDs
2. **Numeric dataset**: Uses `0001-3194` IDs

The same exercises appear in both datasets, with some having different capitalization.

## Recommendations

### Immediate Actions
1. **Remove numeric-ID duplicates** (6 entries) - keep yuhonas_* versions
2. **Normalize case** (112 entries) - convert to Title Case
3. **Update references** - ensure any workout history points to correct IDs

### Prevention
1. Add database uniqueness constraint on `(name, category, equipment)`
2. Enhance seeder to detect and merge duplicates
3. Standardize on Title Case naming convention

## Files Generated
- `scripts/analyze_exercises.py` - Analysis script
- `scripts/final_analysis.py` - Detailed report generator
- `DUPLICATE_EXERCISES_REPORT.md` - Full report
- `lib/utils/remove_duplicates.dart` - Cleanup utility

## Database Schema
- Table: `exercises` with unique constraint on `exercise_id`
- FTS5 virtual table: `exercises_fts` for search
- Related tables: `exercise_muscles`, `exercise_body_parts`, `recent_exercises`

---
**Analysis Date**: 2026-04-28
**Total Exercises Analyzed**: 2,197
**Duplicate Rate**: 0.55% (exact), 10.24% (case-insensitive)
