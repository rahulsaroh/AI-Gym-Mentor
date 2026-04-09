# AI Gym Mentor 🏋️‍♂️

AI Gym Mentor is a feature-rich Flutter application designed to be your ultimate workout companion. It provides comprehensive tools for logging workouts, tracking exercise progress, managing training programs, and analyzing fitness trends with a modern, reactive interface.

---

## 🚀 Project Status
| Module | Status | Notes |
| :--- | :--- | :--- |
| **Workout Logging** | ✅ Stable | Core logging functionality is functional. |
| **Exercise Library** | ✅ Stable | Large database of exercises with filtering. |
| **Programs** | 🏗️ Beta | Workout templates and programs. |
| **History & Analytics**| ✅ Stable | Visual charts and session history. |
| **Cloud Sync** | 🏗️ Experimental | Firebase integration for backup. |
| **Onboarding** | ✅ Stable | Initial setup and user profile. |

---

## ✨ Current Features

### 1. Workout Session Tracking
- Live workout logging with set-tracking (reps, weight, RPE).
- Resting timer and set completion notifications.
- Shake-to-report or gesture-based interactions.

### 2. Comprehensive Exercise Library
- Searchable database of exercises categorized by muscle groups.
- Detailed history and personal records for each exercise.

### 3. Program Management
- Create and manage 4-6 day workout routines (e.g., PPL, Upper/Lower).
- Export and import programs via JSON.

### 4. History & Analytics
- Visualized progress charts using `fl_chart`.
- Detailed workout summaries and volume tracking.

### 5. Data Sovereignty
- Local-first database using **Drift (SQLite)**.
- Manual and automatic backup/restore features (CSV/Excel).
- PDF report generation for workout summaries.

### 6. Background Services & Notifications
- Persistent notification during active workouts.
- Support for background timers and data synchronization.

---

## 🛠 Tech Stack
- **Framework:** Flutter (target SDK `>=3.3.4 <4.0.0`)
- **State Management:** Riverpod (Generator)
- **Database:** Drift (Persistent local storage)
- **Backend:** Firebase (Auth, Cloud Storage for sync)
- **Local Services:** WorkManager, Background Services
- **UI Components:** Google Fonts, Lucide Icons, Shimmer

---

## 🏁 Getting Started

### Prerequisites
- Flutter SDK (Recommended: `3.22.x` or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Java 17+ (for Android builds)

### Setup Instructions
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/rahulsaroh/AI-Gym-Mentor.git
    cd AI-Gym-Mentor
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Code Generation:**
    This project uses `build_runner` for Drift and Riverpod. Run the following command to generate necessary files:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Environment Setup:**
    - Copy `.env.example` to `.env` and fill in the required keys.
5.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 🔥 Firebase Setup
- Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are placed in their respective directories.
- Run `flutterfire configure` if you have the CLI installed to update `lib/firebase_options.dart`.

---

## 🧪 Testing
- **Unit Tests:** `flutter test`
- **Analysis:** `flutter analyze`
- **Formatting:** `dart format .`

---

## ⚠️ Known Limitations
- Background services may be restricted by aggressive battery optimization on some Android manufacturers (Xiaomi, Samsung).
- Cloud sync is currently in experimental phase and requires a stable internet connection.
- PDF generation may vary slightly in layout across different screen sizes.

---

## 🧼 Repository Hygiene
This project maintains a clean repository structure.
- **Log files and debug artifacts** are strictly ignored.
- **Historical data/reports** are archived in `dev/archive/`.
- **Database files** should never be committed to version control.

---

Designed with ❤️ for fitness enthusiasts.
