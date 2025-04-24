import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCcCH-WJN3cXZq64CHbIFR5otLQgYmY9gU',
    appId: '1:560624316773:web:033b8f56c2b754569d718c',
    messagingSenderId: '560624316773',
    projectId: 'learning-resource-app-c9774',
    authDomain: 'learning-resource-app-c9774.firebaseapp.com',
    storageBucket: 'learning-resource-app-c9774.firebasestorage.app',
    measurementId: 'G-NHDGWQFSYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcCH-WJN3cXZq64CHbIFR5otLQgYmY9gU',
    appId: '1:560624316773:android:46eeca634a291ed19d718c',
    messagingSenderId: '560624316773',
    projectId: 'learning-resource-app-c9774',
    storageBucket: 'learning-resource-app-c9774.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcCH-WJN3cXZq64CHbIFR5otLQgYmY9gU',
    appId: '1:560624316773:ios:46eeca634a291ed19d718c',
    messagingSenderId: '560624316773',
    projectId: 'learning-resource-app-c9774',
    storageBucket: 'learning-resource-app-c9774.firebasestorage.app',
    iosClientId: '560624316773-00000000000000000000000000000000.apps.googleusercontent.com',
    iosBundleId: 'com.example.lrapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR-MACOS-API-KEY',
    appId: 'YOUR-MACOS-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    storageBucket: 'YOUR-STORAGE-BUCKET',
    iosClientId: 'YOUR-MACOS-CLIENT-ID',
    iosBundleId: 'YOUR-MACOS-BUNDLE-ID',
  );
} 