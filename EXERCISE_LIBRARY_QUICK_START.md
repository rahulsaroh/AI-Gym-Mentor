# Quick Start Guide - GitHub Exercise Library

## 🎯 Getting Started

### Step 1: Run the App
```bash
flutter clean
flutter pub get
flutter run
```

### Step 2: Navigate to Exercise Library
1. Open the app
2. Go to **Settings** (bottom navigation)
3. Scroll to **"Tools & Library"** section
4. Tap **"GitHub Exercise Library"**

### Step 3: Browse Exercises
- **Grid View**: See exercise previews with loading animation
- **Search**: Type exercise name (e.g., "squat", "bench press")
- **Filter**: Click body part chips (chest, back, legs, etc.)
- **More Filters**: Toggle to see equipment filter options

### Step 4: View Exercise Details
1. Tap any exercise card
2. See full-size GIF (tap to expand)
3. Read step-by-step instructions
4. View secondary muscles
5. Tap "Add to Workout" button

---

## 🧪 Test Scenarios

### ✅ Test 1: Initial Load (Network Required)
1. Launch app
2. Navigate to Exercise Library
3. **Expected**: Grid loads with ~1300 exercises (takes 5-30 seconds on first load)
4. **Check**: See exercise names, GIFs loading with shimmer effect

### ✅ Test 2: Search
1. Type "squat" in search bar
2. **Expected**: Filtered results showing squat variations
3. Type "dumbbell"
4. **Expected**: All dumbbell exercises appear

### ✅ Test 3: Filter by Body Part
1. Click "chest" chip
2. **Expected**: Only chest exercises visible, result count updates
3. Click "legs" chip
4. **Expected**: Only leg exercises visible

### ✅ Test 4: Combined Filters
1. Select "chest" body part
2. Toggle "More Filters" → select "dumbbell"
3. **Expected**: Only chest + dumbbell exercises
4. Tap "Clear" button
5. **Expected**: All exercises, all filters reset

### ✅ Test 5: Exercise Detail
1. Tap any exercise card
2. **Expected**: Full-screen detail with large GIF
3. Scroll down → see instructions, secondary muscles
4. Tap GIF → see fullscreen dialog

### ✅ Test 6: Offline Support
1. Close app
2. Turn OFF internet/WiFi
3. Reopen app → Exercise Library
4. **Expected**: Cached exercises display (if previously fetched)
5. Toggle "More Filters" → categories still load
6. Turn internet back ON → "Add to Workout" works

### ✅ Test 7: Clear Cache
1. Go to Settings → Exercise Library
2. Pull down to refresh (swipe from top)
3. **Expected**: Fresh network fetch, progress indicator appears

### ✅ Test 8: Missing GIF Handling
1. Search for "exercise" 
2. Some GIFs may fail to load
3. **Expected**: Fallback icon appears, no app crash

---

## 🔍 Debugging Tips

### Check if CSV Loaded
Look for exercises count in UI (e.g., "Showing 1234 exercises")

### Enable Debug Logs
Add to `github_exercise_service.dart`:
```dart
debugPrint('Fetched ${exercises.length} exercises');
debugPrint('Parsing took: (DateTime.now() - start).inMilliseconds ms');
```

### Verify Cache
Check SharedPreferences in device settings:
- Key: `github_exercises_cache`
- Key: `github_exercises_cache_timestamp`

### Test GIF URLs
Manually check if GIF URLs work:
```
https://raw.githubusercontent.com/rahulsaroh/exercises-gifs/main/assets/0001.gif
https://raw.githubusercontent.com/rahulsaroh/exercises-gifs/main/assets/0007.gif
```

Some IDs are missing (e.g., 0004, 0005) - this is expected.

---

## 📊 Performance Expectations

| Action | Expected Time |
|--------|---------------|
| First load (network) | 5-30 seconds |
| Subsequent loads (cache) | <1 second |
| Search filtering | <500ms |
| GIF loading per image | 2-5 seconds |
| Detail screen navigation | <500ms |

---

## 🐛 Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| "No exercises found" | Check internet connection, retry refresh |
| GIFs showing as error icons | Some assets are missing on GitHub - expected |
| Search not working | Try shorter keywords, check network |
| Filters sticky after clear | Tap "Clear" button once more |
| App crashes on detail view | Report with exercise ID causing issue |

---

## 📱 Device Testing

### Android
```bash
flutter run -d emulator
# or
flutter run -d <device-id>
```

### iOS
```bash
flutter run -d simulator
# or
flutter run -d <device-id>
```

---

## 🎨 UI Customization Reference

Want to modify the look?

### Change Colors
File: `github_exercise_card.dart`
```dart
_buildBadge(context, exercise.bodyPart, Colors.blue);  // Change color here
```

### Change Grid Columns
File: `github_exercise_library_screen.dart`
```dart
crossAxisCount: 3,  // Change 2 to 3 for 3-column layout
```

### Change Search Placeholder
File: `github_exercise_library_screen.dart`
```dart
hintText: 'Search exercises...',  // Change text here
```

---

## 📞 Support

If you encounter issues:
1. Check logs in terminal output
2. Verify internet connection
3. Try hot reload (`r`) or hot restart (`R`)
4. Clear cache and restart app
5. File GitHub issue if problem persists

---

**Ready to test! 🚀**
