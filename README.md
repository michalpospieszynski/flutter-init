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
   ```
   This template already includes `firebase_core` and `firebase_auth`, and initializes Firebase before `runApp`. Run `flutterfire configure` on each checkout to generate its ignored local configuration files.
3. **Enable providers** (Authentication > Sign-in method):
   - *Email/Password* and *Google*: just enable them.
   - *Microsoft*: register an app in Azure (Entra ID > App registrations), add the redirect URI shown by Firebase (`https://<PROJECT_ID>.firebaseapp.com/__/auth/handler`), create a client secret, and paste the client ID and secret into Firebase.
4. **Platform setup:**
   - *Android:* run `gradlew signingReport` in `android/`, add the SHA-1 and SHA-256 (debug and release) to your Firebase Android app, and re-run `flutterfire configure`. Google sign-in fails without them. Set `minSdk` to 23 if the build asks for it.
   - *iOS (Mac needed):* add `REVERSED_CLIENT_ID` from `GoogleService-Info.plist` as a URL scheme in `Info.plist`, then `cd ios && pod install`.
   - *Web:* add your domains under Authentication > Settings > Authorized domains.
5. **Auth wiring:** `FirebaseAuthService` (`lib/features/auth/data/firebase_auth_service.dart`) implements `AuthService` and is passed to the app in `main.dart`. It covers Google, Microsoft (Entra ID, via Firebase's `microsoft.com` provider) and email/password. Keep provider-specific code in the data layer.
6. **Secure it:** write Firestore security rules (users access only `users/<uid>`), restrict API keys in Google Cloud, and never commit `google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart`, `config/firebase.yaml` or any secrets. They are already git-ignored.

### 4. Secrets and local configuration (not in git)

Secrets and project-specific files are git-ignored. The repository only contains `*.example` templates with `<PLACEHOLDER>` values. After cloning, create the real files:

| Real file (git-ignored) | Template (tracked) | How to get the values |
|---|---|---|
| `lib/firebase_options.dart` | `lib/firebase_options.example.dart` | Run `flutterfire configure --project=<PROJECT_ID> --platforms=android,ios,web` (recommended), or copy the template and fill it from Firebase console > Project settings > Your apps. **Required: `lib/main.dart` imports it.** |
| `android/app/google-services.json` | `android/app/google-services.json.example` | Firebase console > Project settings > Your apps > Android > download `google-services.json`. Optional for building, needed for native Firebase on Android. |
| `ios/Runner/GoogleService-Info.plist` | `ios/Runner/GoogleService-Info.plist.example` | Firebase console > Project settings > Your apps > iOS > download, then add it to the Runner target in Xcode. |
| `android/key.properties` + keystore (`*.jks`) | `android/key.properties.example` | Create a keystore with the `keytool` command in the template and keep it **outside** the repository. Without it, release builds are signed with the debug key. |
| `config/firebase.yaml` | `config/firebase.example.yaml` | Optional personal reference sheet. The app does not read it. |
| `firebase.json`, `.firebaserc` | none | Generated by `flutterfire configure` / `firebase init`. They contain project and app IDs. |

Where the **real secrets** live (never in this repository, not even as placeholders):

- **Microsoft Entra ID client secret**: Azure portal > App registrations > Certificates & secrets. Copy the secret **Value** (not the Secret ID) once and paste it only into Firebase console > Authentication > Sign-in method > Microsoft. Only the Application (client) ID is not secret.
- **Google OAuth client secret / service-account keys / Admin SDK JSON**: Google Cloud console. The app does not need them. Never download them into the project folder (`service-account*.json` and `*-adminsdk-*.json` are git-ignored as a safety net).
- **Keystore and passwords**: your password manager or CI secret store.
- **CI/CD**: store the files above as encrypted CI secrets and write them during the build, e.g. `echo "$GOOGLE_SERVICES_JSON" > android/app/google-services.json`.

Firebase web/Android/iOS API keys are client identifiers, not secrets, but keep them out of git anyway so each environment (dev/staging/prod) uses its own project. Restrict them in Google Cloud console (HTTP referrers for web, package name and SHA for Android, bundle ID for iOS) and protect data with Firestore security rules.

`assets` that are committed on purpose: `base_app_config.yaml` holds the public app name and author/contact details shown in the UI. Do not put anything private in it, because it is bundled into the app.

If a secret was ever committed, rotate it (create a new one, delete the old one) and purge it from history. Removing it in a later commit is not enough.

### 5. Before release

Set up Android signing (copy `android/key.properties.example` to `android/key.properties`, add the release SHA to Firebase) and iOS signing in Xcode, then build with `flutter build appbundle`, `flutter build ipa` or `flutter build web`.

## App structure & design

- **Name/brand:** Aurora, with the *Indigo Aurora* palette (primary #4F46E5, secondary #7C3AED, accent #22D3EE). Tokens live in lib/core/theme/ (light, dark and system modes, Inter font).
- **Navigation:** go_router with an auth-aware redirect. / is the landing page; /home, /profile and /settings sit in an adaptive shell (NavigationRail on wide screens, NavigationBar on mobile).
- **Auth UI:** lib/features/auth/ (Google, Microsoft, email/password, password reset, email verification, provider linking).
- **Tests:** flutter test (uses test/fake_auth_service.dart).


Full UI/UX concept: see [DESIGN.md](DESIGN.md).
