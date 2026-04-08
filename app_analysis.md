# App Analysis: AI Gym Mentor (Gym Gemini Pro)
> 💡 Tip: This document is a comprehensive audit of the **AI Gym Mentor** Flutter app. It provides a detailed snapshot of the app's current state, architecture, and features to enable deep AI-driven analysis.

## 1. App Overview
> 💡 Tip: High-level summary of the app's purpose and status.

- **App Name:** AI Gym Mentor (Internal: Gym Gemini Pro)
- **Tagline:** Your AI-powered personal trainer for plateau breaking and progression tracking.
- **Target Audience:** Intermediate to advanced lifters, data-driven fitness enthusiasts, and those stuck in a training plateau.
- **One-line Description:** A feature-rich workout tracker that uses algorithmic analysis to detect plateaus and suggest intelligent deloads/progressions.
- **Detailed Description:** AI Gym Mentor combines traditional workout logging with specialized services like `PlateauService` and `ProgressionService`. It allows users to build custom programs, search a library of 800+ exercises with GIF demonstrations, and sync data seamlessly with Google Sheets as a low-cost, decentralized backend.
- **Current Development Stage:** `[ ] Idea / [ ] Prototype / [x] MVP / [x] Beta / [ ] Production`
- **Platform Targets:** `[x] Android / [x] iOS / [x] Both`
- **Monetization Model:** Planned Freemium (Free core tracking, AI-driven program generation as Premium).

---

## 2. Core Features List
> 💡 Tip: Audit of the current implementation status.

| Feature Name | Implemented | Notes / Current Behavior |
| :--- | :---: | :--- |
| **User Onboarding & Profile Setup** | Yes | `OnboardingScreen` and `SetupScreen` for initial user data. |
| **Workout Creation and Logging** | Yes | Robust `ActiveWorkoutScreen` with real-time logging and rest timers. |
| **Exercise Database & Search** | Yes | 800+ exercises with local search and filtering by equipment/category. |
| **Pre-built Workout Plans** | Yes | Found under the `programs` feature; supports template-driven starts. |
| **Custom Workout Builder** | Yes | `CreateEditProgramScreen` allows full customization of routines. |
| **Progress Tracking (Weight/Reps/Vol)** | Yes | Dedicated `AnalyticsDashboard` with volume and 1RM charts. |
| **Body Measurements Tracking** | Yes | `BodyMeasurementsScreen` tracks weight and other metrics over time. |
| **Rest Timer** | Yes | Global `TimerService` tracks rest periods between sets. |
| **Workout History & Calendar View** | Yes | `HistoryScreen` with a calendar-style workout log. |
| **Nutrition / Calorie Tracking** | No | Currently focused strictly on training. |
| **Water Intake Tracking** | No | Not implemented. |
| **Step Counter / Activity Tracking** | No | Not implemented. |
| **Streak & Gamification** | Partial | `PRHallOfFameScreen` celebrates personal records. |
| **Social Features (Friends/Share)** | No | `Firebase` integration is prepared but currently disabled in `main.dart`. |
| **Notifications & Reminders** | Yes | `NotificationService` handles workout reminders and timer updates. |
| **Offline Mode** | Yes | Local-first architecture using `Drift` (SQLite). |
| **Dark/Light Theme** | Yes | Full support with Material 3 dynamic color-seeding. |
| **Wearable Integration** | No | Not implemented. |
| **AI-Powered Suggestions** | Yes | `PlateauService` analyzes the last 5 sessions to detect stagnation. |
| **Video/GIF Exercise Demos** | Yes | `ExerciseMediaWidget` displays GIFs for library exercises. |

---

## 3. App Navigation & Screen Architecture
> 💡 Tip: Structural overview of user movement through the app.

- **Navigation Pattern:** Bottom Navigation Bar using `StatefulShellRoute` (IndexedStack).
- **Deep Linking Support:** `[x] Yes / [ ] No` (Configured via `GoRouter`).
- **Back Navigation Behavior:** Standard system back with `PopScope` used in active workout to prevent accidental exit.
- **Modal/Sheet Usage:** Persistent bottom sheets for exercise filtering and workout summary.

### Screen Registry
| Screen Name | Route Name | Accessed From | Purpose | Auth Required |
| :--- | :--- | :--- | :--- | :---: |
| Splash | `/` | Root | App initialization | No |
| Onboarding | `/onboarding` | Splash | Introduction for new users | No |
| Workout Home | `/app` | Nav Tab 1 | Main dashboard and "Start Workout" | Yes |
| Exercise Library | `/exercises` | Nav Tab 2 | Browse/Search exercises | No |
| History | `/history` | Nav Tab 3 | View past sessions | Yes |
| Programs | `/programs` | Nav Tab 4 | Manage workout templates | Yes |
| Analytics | `/analytics` | Nav Tab 5 | View progress charts & PRs | Yes |
| Active Workout | `/app/workout/active` | Home | Real-time logging interface | Yes |
| Settings | `/settings` | Nav Tab 6 | Configuration & Sync | No |

### Navigation Flow (ASCII/Text)
```text
[Splash] -> [Onboarding] -> [Setup] -> [Main Shell]
                                          |
        +----------------+----------------+----------------+----------------+
        |                |                |                |                |
  [Workout Home]   [Exercises]      [History]        [Programs]       [Analytics]
        |                |                |                |                |
  [Active Workout] [Detail/Media]   [Workout Detail] [Program Build]  [PR Hall/Body]
```

---

## 4. UI/UX Design Details
> 💡 Tip: Visual logic and component standards.

- **Design System:** Material 3 (M3) with Custom Seeded Color Scheme.
- **Primary Color:** Seeded from `settings.accentColor` (User-configurable).
- **Accent Color:** Customizable via `PlatesConfigScreen` and global settings.
- **Typography:** `GoogleFonts` (Inter/Roboto default).
- **Spacing/Padding:** Consistent 8/16/24dp system.
- **Component Library:** Standard Flutter M3 Widgets + Shimmer for loading.
- **Animations:** `Hero` transitions for exercise media, `Lottie` (planned/in assets), and `AnimateTheme` for smooth dark/light switching.
- **Loading/Empty States:** `Shimmer` skeletons for lists; "No data" illustrations for empty charts.
- **Error Handling:** `GlobalErrorHandler` and custom `GlobalErrorScreen` to prevent "Red Screen of Death".
- **Accessibility:** Font scaling support in `ThemeData`, semantic labels on icons.
- **Onboarding Flow:** Multi-step carousel with a "Setup" screen to gather initial fitness level and goals.

---

## 5. State Management & Architecture
> 💡 Tip: Technical organization and data flow.

- **State Management:** `Riverpod` (2.x) with `@riverpod` code generation for typesafety.
- **Architecture Pattern:** Feature-first Architecture.
- **Folder Structure:** 
```text
lib/
 ├── core/              # Global router, db, theme, providers
 ├── features/          # Feature-specific logic (analytics, workout, etc.)
 │   ├── [feature]/
 │   │   ├── models/    # Data structures (Freezed)
 │   │   ├── widgets/   # Local UI components
 │   │   └── provider/  # Feature state (Notifiers)
 ├── services/          # Cross-cutting concerns (Sync, AI, Connectivity)
 └── main.dart          # Entry point and global error catchers
```
- **Global State:** User settings, active workout session, connectivity status.
- **Local State:** Tab indices, search controllers, micro-animations.

---

## 6. Data Layer
> 💡 Tip: Storage, sync, and backend details.

- **Local Storage:** `Drift` (Reactive SQLite) for structured data; `SharedPreferences` for settings.
- **Remote Backend:** Decentralized `Google Sheets API` for data backup; `Firebase` (prepared for Auth/Storage).
- **Authentication:** `Google Sign-In` linked to Google discovery for Sheets sync; Firebase Auth (on roadmap).
- **Data Sync Strategy:** Offline-first. Edits are saved to SQLite and queued for `SyncWorker` to push to Google Sheets when online.
- **Exercise DB Source:** High-quality local JSON (800+ entries) with images/GIFs.
- **Data Querying:** Reactive streams via Drift allow the UI to update automatically when the DB changes.

---

## 7. Performance & Optimization
> 💡 Tip: Speed and efficiency.

- **Cold Startup Time:** ~1.2s (Measured in debug, optimized via notification/timer init).
- **Warm Startup Time:** Near-instant.
- **Known Jank Areas:** `fl_chart` rendering with very large datasets (100+ points); `ExerciseLibrary` grid scrolling while loading GIFs.
- **Image/GIF Strategy:** `CachedNetworkImage` + `flutter_cache_manager` for smooth media playback.
- **Build Size:** Debug APK: ~65MB | Release APK: Target <25MB.
- **Memory Consumption:** Low (Average 120-180MB RAM) due to stream-based data handling.

---

## 8. Current Pain Points (Self-Reported)
> 💡 Tip: Reality check on the current build quality.

- **Broken/Incomplete:** Firebase initialization is currently commented out in `main.dart` due to plugin configuration conflicts.
- **Confusing Flows:** The transition between "Starting a workout" and "Picking a template" feels redundant to some users.
- **Technical Debt:** `SyncWorker` needs a more robust retry logic for partial network failure (currently simple queue).
- **User Complaints:** Initial feedback indicates some "render overflow" errors on smaller devices in the Workout Summary screen.
- **Subjective "Ugly" Parts:** The "Setup Sheets" flow is utilitarian and lacks the premium feel of the rest of the app.

---

## 9. Competitor Comparison
> 💡 Tip: Benchmark against market leaders.

| Feature | AI Gym Mentor | Strong / Hevy | MyFitnessPal | FitBod |
| :--- | :--- | :--- | :--- | :--- |
| **Workout Logging** | Advanced (Rest Timers) | Excellent | Basic | Auto-generated |
| **AI Analysis** | Plateau Detection | None | None | Predictive Weight |
| **Price** | Free (Open Source Feel) | Subscription / One-time | Heavy Subscription | High Subscription |
| **Data Privacy** | High (Google Sheets) | Medium (Cloud Prop.) | Low (Data Ads) | Medium (Cloud Prop.) |
| **UI Density** | Balanced | High | Very High (Cluttered) | Low (Simplified) |

---

## 10. Packages & Dependencies
> 💡 Tip: Key building blocks.

| Package Name | Version | Purpose | Known Issues |
| :--- | :--- | :--- | :--- |
| `flutter_riverpod` | `^2.5.1` | Global State Management | Boilerplate for providers |
| `drift` | `^2.16.0` | Local SQLite ORM | Code generation time |
| `go_router` | `^13.2.0` | Declarative Navigation | Link nesting complexity |
| `fl_chart` | `^0.66.0` | Progress Visualization | Performance on old TVs/phones |
| `lucide_icons_flutter` | `^1.1.0` | Premium Iconography | None |
| `shimmer` | `^3.0.0` | Skeletal Loading UI | None |
| `googleapis` | `^13.1.0` | Google Sheets/Drive Sync | Heavy package size |

---

## 11. Planned Features & Roadmap
> 💡 Tip: The future of AI Gym Mentor.

- **Near-term (Next 3 Months):** Stabilize Firebase Auth, implement "Weight Plate Calculator" UI.
- **Mid-term (6 Months):** AI Workout Generator based on user plateau history.
- **Long-term Vision:** Computer Vision for rep counting via camera (AI Pose Estimation).
- **Deprioritized Features:** Social Feed (Decided to keep it a private, data-focused tool to avoid "ego-lifting").

---

## 12. Target User Persona
> 💡 Tip: The "Ideal" user.

- **Primary Persona:** "Analytical Alex" – Loves spreadsheets, tracks every RPE (Rate of Perceived Exertion), and gets frustrated when progress stalls without a clear "why".
- **Core Problem Solved:** The "Black Box" of progress stall. Alex doesn't know when to deload or push harder.
- **Typical Session:** Opens app before gym, selects "Push Day A", logs 6 exercises, uses rest timer, checks the PR Hall of Fame after the final set.
- **Retention Hook:** The Weekly Sync to Google Sheets – seeing their data grow in their own spreadsheet.

---

## 13. Monetization & Growth
> 💡 Tip: Sustainability.

- **Revenue Plan:** $4.99/mo for "AI Analysis Pack" (Plateau detection bypass, custom AI routines).
- **Free vs Premium Split:** Everything currently implemented is Free. AI-generation is Premium.
- **Referral Loops:** "Share PR" cards formatted for Instagram/X.
- **Analytics Setup:** Currently using `SyncLogScreen` for internal tracking; Firebase Analytics planned.

---

## Notes for AI Analyzer
> 💡 Tip: Instructions for the analyzing agent.

**Analysis Instructions:**
1. **Critical UX Audit:** Identify friction points, especially in the "Active Workout" to "Summary" flow.
2. **Architecture Review:** Is Riverpod + Drift overkill or just right for the planned AI Workout Generator?
3. **Feature Gap Analysis:** What's missing to beat Hevy/Strong in the "Data Geek" niche?
4. **Performance Risks:** evaluate the `googleapis` impact on startup and `fl_chart` performance.
5. **Growth Suggestions:** Recommend 2 ways to leverage the Google Sheets data for user retention.
