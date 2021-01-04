# swipe

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Retrieve Debug Signing Key
After retrieving the signing key. Register the sha1 and sha2 fingerprints in firebase console project.
- `keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore`
# Generate Development Key (for deployment purpose)
- `keytool -genkey -v -keystore ~/swipeapp.jks -keyalg RSA -keysize 2048 -validity 10000 -alias swipekey`

# Running the project

- flutter packages get
- flutter packages pub run build_runner watch --delete-conflicting-outputs
- flutter run --flavor dev -t lib/main-dev.dart
