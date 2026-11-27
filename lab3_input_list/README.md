# DCIT 26 — Lab 3: Button, Text Input and List

A Flutter screen with a `TextField`, an **ADD** button, and a live list that
updates via `StatefulWidget` + `setState()`.

## What it does (matches the lab checklist)

- Hint text is exactly **"Enter Item"**.
- Pressing **ADD** trims the input and appends one new row only when it is
  non-empty.
- The text field clears after a valid add.
- Blank / whitespace-only input adds nothing.
- The list stays usable with many items, and each row is styled but readable.
- The `TextEditingController` is disposed in `State.dispose()`.

## Run it

The project is fully scaffolded (all platform folders included). Run:

```bash
flutter pub get
flutter run
```

Verified with `flutter analyze` (No issues found) and `flutter build web`.

## Note on `material_ui`

This project targets Flutter 3.50+, which extracts the Material library into
the standalone `material_ui` package (imported via
`package:material_ui/material_ui.dart`). If your course uses an older Flutter
(before 3.47), change the imports back to `package:flutter/material.dart` and
remove the `material_ui` line from `pubspec.yaml`.
