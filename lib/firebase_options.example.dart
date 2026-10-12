// TEMPLATE - copy to `lib/firebase_options.dart` (git-ignored) and replace every
// <PLACEHOLDER>, or simply run `flutterfire configure` which generates the real
// file for you. See "Firebase" in README.md.
//
// Never commit the real `lib/firebase_options.dart`.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '<WEB_API_KEY>',
    appId: '<WEB_APP_ID>', // 1:<number>:web:<hash>
    messagingSenderId: '<SENDER_ID>',
    projectId: '<FIREBASE_PROJECT_ID>',
    authDomain: '<FIREBASE_PROJECT_ID>.firebaseapp.com',
    storageBucket: '<FIREBASE_PROJECT_ID>.firebasestorage.app',
    measurementId: '<GA_MEASUREMENT_ID>', // optional
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '<ANDROID_API_KEY>',
    appId: '<ANDROID_APP_ID>', // 1:<number>:android:<hash>
    messagingSenderId: '<SENDER_ID>',
    projectId: '<FIREBASE_PROJECT_ID>',
    storageBucket: '<FIREBASE_PROJECT_ID>.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '<IOS_API_KEY>',
    appId: '<IOS_APP_ID>', // 1:<number>:ios:<hash>
    messagingSenderId: '<SENDER_ID>',
    projectId: '<FIREBASE_PROJECT_ID>',
    storageBucket: '<FIREBASE_PROJECT_ID>.firebasestorage.app',
    iosBundleId: '<IOS_BUNDLE_ID>',
  );
}
