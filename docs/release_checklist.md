# Release Checklist - GymLog Pro

Use this checklist before every production release to ensure stability, data integrity, and a smooth user experience.

## 1. Versioning & Documentation
- [ ] Increment `version` in `pubspec.yaml` (e.g., `1.0.1+2`).
- [ ] Update `CHANGELOG.md` with new features and fixes.
- [ ] Verify that the `version` displayed in Settings matches `pubspec.yaml`.

## 2. Code Quality & Performance
- [ ] Run `flutter analyze` and resolve all warnings/errors.
- [ ] Run `flutter test` and ensure 100% pass rate.
- [ ] Verify that `build_runner` has been run and generated files are up-to-date.
- [ ] Test the release build locally: `flutter run --release`.
- [ ] Check for any `print` statements or debug comments to be removed.

## 3. Database & Data Integrity
- [ ] Verify `drift` schema migrations if `database.dart` was changed.
- [ ] Test JSON export/import with existing production data.
- [ ] Confirm `CloudIntegrationState` correctly handles the "Guest" (offline) mode.

## 4. Platform Specifics (Android/iOS)
- [ ] **Permissions**: Verify `AndroidManifest.xml` and `Info.plist` for:
  - `POST_NOTIFICATIONS` (Android 13+)
  - `SCHEDULE_EXACT_ALARM`
  - `FOREGROUND_SERVICE`
- [ ] **Icons**: Run `flutter launcher_icons` if the app icon has changed.
- [ ] **ProGuard/R8**: Ensure `proguard-rules.pro` correctly preserves Drift and Freezed classes.
- [ ] **Firebase**: Ensure `google-services.json` and `GoogleService-Info.plist` are correct for the environment.

## 5. Deployment
- [ ] Build App Bundle: `flutter build appbundle`.
- [ ] Build iOS Archive: `flutter build ios --release`.
- [ ] Upload to Play Console / App Store Connect internal tracks first.
- [ ] Monitor crash reporting (Sentry/Firebase) for 24 hours after release.

---
*Created: 2026-04-09*
*Next planned audit: 2026-05-09*
