# flutter_init

Flutter starter template (Android, iOS, web): dark-first Material 3 theme, English/Polish localization, responsive home page and an auth UI ready for Firebase.

## Run the app

**Prerequisites:** [Flutter SDK](https://docs.flutter.dev/get-started/install), Android SDK (for Android), Chrome (for web), a Mac with Xcode (for iOS only). Run `flutter doctor -v` and fix what it reports.

```bash
flutter pub get
flutter emulators --launch <emulator_id>   # or start any device
flutter run -d <device_id>                 # e.g. emulator-5554 or chrome
```

- `flutter devices` lists running devices, `flutter emulators` lists created emulators.
- Run Android and web together in two terminals, one `flutter run -d ...` each.
- While running: `r` hot reload, `R` hot restart, `q` quit. Changes to native files, `pubspec.yaml`, icon or splash need a full re-run. Closing the app on the emulator ends the session.
- Before committing: `dart format lib test`, `flutter analyze`, `flutter test`.

**Troubleshooting**

- *`Package ndk not found`:* install it manually, e.g. `sdkmanager "ndk/28.2.13676358"` (use the version from the error).
- *Stuck on the splash screen:* start with Run, not Debug, so the app doesn't wait for a debugger.

## Reconfigure

Do this after creating a new project from the template.

### 1. Rename

First decide two names, then use them in the table below:

- **Display name**: what users see under the app icon and in the title bar, with spaces and capitals allowed. Example: `My Notes`.
- **Identifier** (reverse domain): a unique, lowercase ID for your app, usually your domain backwards. Example: `com.mycompany.mynotes`. It can't contain spaces or dashes, and can't be changed after you publish. Firebase registers your apps by this ID, so choose it before the Firebase setup.
- **Package name** (Dart): lowercase with underscores. Example: `my_notes`.

| Setting | What it is | Template value | Change it to (example) | File |
|---------|-----------|----------------|------------------------|------|
| `name` | Dart package name | `flutter_init` | `my_notes` | `pubspec.yaml`. Also update every `package:flutter_init/...` import in `test/` and `lib/`. |
| `description` | One-line project description | `Flutter app init` | `A simple notes app` | `pubspec.yaml`, `web/index.html` (`<meta name="description">`), `web/manifest.json` |
| `appName` | Name shown in the app bar, footer and window title | `AppName` | `My Notes` | `lib/l10n/app_en.arb` and `app_pl.arb` |
| `android:label` | Name shown under the app icon on Android | `flutter_init` | `My Notes` (your display name) | `android/app/src/main/AndroidManifest.xml` |
| `namespace` and `applicationId` | Android's unique app ID, also used by Google Play and Firebase | `pl.mpospieszynski.flutter_init` | `com.mycompany.mynotes` (your identifier; use the same value in both) | `android/app/build.gradle.kts` |
| `MainActivity` package | Android source folder and `package` line must match the ID above | `pl/mpospieszynski/flutter_init/` | `com/mycompany/mynotes/` | `android/app/src/main/java/...` (move the folder, update the `package` line) |
| `CFBundleDisplayName` | Name shown under the app icon on iOS | `Flutter Init` | `My Notes` | `ios/Runner/Info.plist` |
| `CFBundleName` | Short internal iOS app name | `flutter_init` | `my_notes` | `ios/Runner/Info.plist` |
| `PRODUCT_BUNDLE_IDENTIFIER` | iOS's unique app ID (the bundle ID). May equal the Android ID | `pl.mpospieszynski.flutterInit` | `com.mycompany.mynotes` | Xcode: Runner target > Signing & Capabilities (or `ios/Runner.xcodeproj/project.pbxproj`) |
| `<title>`, `apple-mobile-web-app-title` | Browser tab and home-screen name | `flutter_init` | `My Notes` | `web/index.html` |
| `name`, `short_name` | Name when the web app is installed (PWA); `short_name` is shown under the icon | `flutter_init` | `My Notes` | `web/manifest.json` |

Tip: search the project for `flutter_init` and `mpospieszynski` to find anything you missed.

### 2. Branding and content

- Replace the images in `assets/icon/` (1024x1024 PNG), then regenerate:
  ```bash
  dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
  dart run flutter_native_splash:create --path=flutter_native_splash.yaml
  ```
- Theme colors: `lib/core/theme/app_theme.dart` (`_seed` is the main accent color, as `0xFF` plus a hex code, e.g. `0xFF0EA5E9`). Default theme mode: `lib/app.dart` (`ThemeMode.dark`, or `ThemeMode.system` to follow the device).
- Texts: edit the `.arb` files in `lib/l10n/`, then `flutter gen-l10n`. To add a language, add an `app_<code>.arb` and a segment in `language_switcher.dart`.
- Footer links: set the three addresses in `lib/core/config/app_links.dart`: the page with your privacy policy, the page with your terms of service, and a `mailto:` support address (for example `mailto:support@mycompany.com`). App stores require a real privacy policy.

### 3. Firebase

`config/firebase.example.yaml` lists every value you will need. Copy it to `config/firebase.yaml` (git-ignored) and fill it in as a reference. The app does not read it, and it must not contain secrets.

1. **Create the project** in the [Firebase console](https://console.firebase.google.com/). Firebase gives it a **project ID** (e.g. `my-notes-prod`); that is the `<PROJECT_ID>` used below. Enable Authentication and Cloud Firestore (its location can't be changed later).
2. **Connect the app:**
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   firebase login
   flutterfire configure --project=<PROJECT_ID> --platforms=android,ios,web
   flutter pub add firebase_core firebase_auth google_sign_in cloud_firestore
   ```
   Then call `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` in `main.dart` before `runApp`.
3. **Enable providers** (Authentication > Sign-in method):
   - *Email/Password* and *Google*: just enable them.
   - *Microsoft*: register an app in Azure (Entra ID > App registrations), add the redirect URI shown by Firebase (`https://<PROJECT_ID>.firebaseapp.com/__/auth/handler`), create a client secret, and paste the client ID and secret into Firebase.
4. **Platform setup:**
   - *Android:* run `gradlew signingReport` in `android/`, add the SHA-1 and SHA-256 (debug and release) to your Firebase Android app, and re-run `flutterfire configure`. Google sign-in fails without them. Set `minSdk` to 23 if the build asks for it.
   - *iOS (Mac needed):* add `REVERSED_CLIENT_ID` from `GoogleService-Info.plist` as a URL scheme in `Info.plist`, then `cd ios && pod install`.
   - *Web:* add your domains under Authentication > Settings > Authorized domains.
5. **Implement the service:** create `FirebaseAuthService` implementing `AuthService` (`lib/features/auth/domain/auth_service.dart`) and use it instead of `NoopAuthService` in `main.dart`. The email button still needs a sign-up form.
6. **Secure it:** write Firestore security rules (users access only `users/<uid>`), restrict API keys in Google Cloud, and never commit `google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart`, `config/firebase.yaml` or any secrets. They are already git-ignored.

### 4. Before release

Set up Android signing (add the release SHA to Firebase) and iOS signing in Xcode, then build with `flutter build appbundle`, `flutter build ipa` or `flutter build web`.
