# DCIT 26 — Lab 7: Networking

Fetches one random user from `https://randomuser.me/api/`, shows a preview on
the Home screen, and opens a structured Profile screen when the picture is
tapped.

## What it does (matches the lab checklist)

- Makes the request **on init** (in `initState`), not in `build()`.
- Checks `response.statusCode` before decoding, then parses `results[0]` into a
  typed `RandomUser` model.
- Home shows the picture + name, a **Fetch New User** button, and a visible
  loading / error / retry state.
- Tapping the picture navigates to the Profile screen with the *exact* user
  object currently shown (no refetch).
- Profile shows name, gender, location (street/city/state/country/postcode and
  timezone), email, date of birth/age, registration date, phone/cell, ID
  name/value, nationality and picture, plus username + UUID as account IDs.
  Missing fields are skipped gracefully. Password/salt/md5/sha1/sha256 are
  **never** parsed or displayed.
- The network image has a loading indicator and an error fallback.

## Run it

The project is fully scaffolded. The `http` package is already in `pubspec.yaml`.

```bash
flutter pub get
flutter run
```

Verified with `flutter analyze` (No issues found) and `flutter build web`.

## Platform config (already applied)

- **Android**: `android/app/src/main/AndroidManifest.xml` already includes
  `<uses-permission android:name="android.permission.INTERNET"/>`.
- **macOS**: both `DebugProfile.entitlements` and `Release.entitlements`
  already include `com.apple.security.network.client`.
- **Windows / Web / Linux**: no extra config; on web `randomuser.me` supports CORS.

## Note on `material_ui`

This project targets Flutter 3.50+, which extracts the Material library into
the standalone `material_ui` package (imported via
`package:material_ui/material_ui.dart`). If your course uses an older Flutter
(before 3.47), change the imports back to `package:flutter/material.dart` and
remove the `material_ui` line from `pubspec.yaml`.
