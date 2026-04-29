#!/usr/bin/env python3
"""
Duplicate Exercise Finder for AI Gym Mentor

Usage:
    python find_exercise_duplicates.py [--fix]

This script analyzes the exercises.json file for duplicate entries
based on multiple matching criteria.

Output:
    - Summary of duplicates found
    - Detailed list of duplicate groups
    - Recommendations for cleanup

With --fix flag:
    - Also generates SQL/NoSQL commands to remove duplicates
"""

import json
import sys
from collections import defaultdict
from typing import List, Dict, Any, Tuple

# Configuration
EXERCISES_FILE = 'assets/data/exercises.json'

def load_exercises(filepath: str) -> List[Dict[str, Any]]:
    """Load exercises from JSON file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        return json.load(f)

def group_by_exact_name(exercises: List[Dict]) -> Dict[str, List[Dict]]:
    """Group exercises by exact name match."""
    groups = defaultdict(list)
    for ex in exercises:
        groups[ex['name']].append(ex)
    return {k: v for k, v in groups.items() if len(v) > 1}

def group_by_case_insensitive(exercises: List[Dict]) -> Dict[str, List[Dict]]:
    """Group exercises by case-insensitive name match."""
    groups = defaultdict(list)
    for ex in exercises:
        groups[ex['name'].lower().strip()].append(ex)
    return {k: v for k, v in groups.items() if len(v) > 1}

def group_by_full_key(exercises: List[Dict]) -> Dict[Tuple, List[Dict]]:
    """Group by (name, category, equipment) key."""
    groups = defaultdict(list)
    for ex in exercises:
        key = (
            ex['name'].lower().strip(),
            ex.get('category', '').lower().strip(),
            ex.get('equipment', '').lower().strip(),
        )
        groups[key].append(ex)
    return {k: v for k, v in groups.items() if len(v) > 1}

def has_yuhonas_id(exercise: Dict) -> bool:
    """Check if exercise has yuhonas_* ID."""
    eid = exercise.get('id', '')
    return isinstance(eid, str) and eid.startswith('yuhonas_')

def has_numeric_id(exercise: Dict) -> bool:
    """Check if exercise has numeric ID."""
    eid = exercise.get('id', '')
    return isinstance(eid, str) and eid.isdigit()

def analyze(exercises: List[Dict]) -> Dict[str, Any]:
    """Perform complete duplicate analysis."""
    results = {
        'total': len(exercises),
        'exact_duplicates': {},
        'case_insensitive': {},
        'full_duplicates': {},
    }
    
    # Exact name duplicates
    exact = group_by_exact_name(exercises)
    results['exact_duplicates'] = {
        'groups': len(exact),
        'entries': sum(len(v) for v in exact.values()),
        'details': exact,
    }
    
    # Case-insensitive
    ci = group_by_case_insensitive(exercises)
    ci_filtered = {
        k: v for k, v in ci.items()
        if len(set(e['name'] for e in v)) > 1
    }
    results['case_insensitive'] = {
        'groups': len(ci_filtered),
        'entries': sum(len(v) for v in ci_filtered.values()),
        'details': ci_filtered,
    }
    
    # Full duplicates
    full = group_by_full_key(exercises)
    results['full_duplicates'] = {
        'groups': len(full),
        'entries': sum(len(v) for v in full.values()),
        'details': full,
    }
    
    return results

def print_report(results: Dict[str, Any]):
    """Print formatted analysis report."""
    print('=' * 70)
    print('  DUPLICATE EXERCISE ANALYSIS REPORT')
    print('=' * 70)
    print('\nTotal exercises analyzed: %d' % results['total'])
    
    # Exact duplicates
    print('\n' + '-' * 70)
    print('1. EXACT NAME DUPLICATES')
    print('-' * 70)
    exact = results['exact_duplicates']
    print('   Groups: %d' % exact['groups'])
    print('   Affected entries: %d' % exact['entries'])
    
    for name, items in sorted(exact['details'].items(), key=lambda x: -len(x[1])):
        print('\n   "%s" (%d duplicates):' % (name, len(items)))
        for ex in items:
            eid = ex.get('id', 'N/A')
            cid = ex.get('category', '?')
            eq = ex.get('equipment', '?')
            diff = ex.get('difficulty', '?')
            print('     • %-25s | %-12s | %-20s | %s' % (eid, cid, eq, diff))
    
    # Case-insensitive
    print('\n' + '-' * 70)
    print('2. CASE-INSENSITIVE DUPLICATES (Different Capitalization)')
    print('-' * 70)
    ci = results['case_insensitive']
    print('   Groups: %d' % ci['groups'])
    print('   Affected entries: %d' % ci['entries'])
    
    count = 0
    for name, items in sorted(ci['details'].items(), key=lambda x: -len(x[1])):
        if count >= 10:
            remaining = len(ci['details']) - 10
            print('\n   ... and %d more groups' % remaining)
            break
        name_variants = set(e['name'] for e in items)
        print('\n   "%s" (%d entries, %d variants):' % (name.title(), len(items), len(name_variants)))
        print('     Names: %s' % ', '.join(sorted(name_variants)))
        for ex in items:
            print('       • %s' % ex.get('id', 'N/A'))
        count += 1
    
    # Full duplicates
    print('\n' + '-' * 70)
    print('3. FULL DUPLICATES (Same Name + Category + Equipment)')
    print('-' * 70)
    full = results['full_duplicates']
    print('   Groups: %d' % full['groups'])
    print('   Affected entries: %d' % full['entries'])
    
    for (name, cat, eq), items in sorted(full['details'].items(), key=lambda x: -len(x[1])):
        print('\n   "%s"' % name)
        print('     Category: %s | Equipment: %s' % (cat, eq))
        print('     -> %d entries:' % len(items))
        for ex in items:
            print('       • %s' % ex.get('id', 'N/A'))
    
    # Summary
    print('\n' + '=' * 70)
    print('SUMMARY')
    print('=' * 70)
    print('   Total exercises:                    %d' % results['total'])
    print('   Exact name duplicate groups:        %d' % exact['groups'])
    print('   Exact name duplicate entries:       %d' % exact['entries'])
    print('   Case-insensitive duplicate groups:  %d' % ci['groups'])
    print('   Case-insensitive duplicate entries: %d' % ci['entries'])
    print('   Full duplicate groups:              %d' % full['groups'])
    print('   Full duplicate entries:             %d' % full['entries'])
    print('\n   Duplicate rate (exact):             %.2f%%' % (exact['entries']/results['total']*100))
    print('   Duplicate rate (case-insensitive):  %.2f%%' % (ci['entries']/results['total']*100))
    
    print('\n' + '=' * 70)
    print('RECOMMENDATIONS')
    print('=' * 70)
    print('\n   1. Remove numeric-ID duplicates (prefer yuhonas_* versions)')
    print('   2. Normalize case to Title Case format')
    print('   3. Add database uniqueness constraints')
    print('   4. Enhance build process to detect duplicates')
    print()

def main():
    try:
        exercises = load_exercises(EXERCISES_FILE)
    except FileNotFoundError:
        print('Error: Could not find %s' % EXERCISES_FILE, file=sys.stderr)
        print('Please run from the project root directory.', file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print('Error: Invalid JSON in %s: %s' % (EXERCISES_FILE, e), file=sys.stderr)
        sys.exit(1)
    
    results = analyze(exercises)
    print_report(results)

if __name__ == '__main__':
    main()
