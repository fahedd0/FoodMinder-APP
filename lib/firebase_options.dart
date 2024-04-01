// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDtXdCCpzK_fmfK3GE7IROzJK-jHIG868w',
    appId: '1:114976838811:web:b8f4ad748e7d0358ae623e',
    messagingSenderId: '114976838811',
    projectId: 'phase2-c7a65',
    authDomain: 'phase2-c7a65.firebaseapp.com',
    storageBucket: 'phase2-c7a65.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbekLWZu_SZpK4O7cS4wiZdQL0dpb_13Q',
    appId: '1:114976838811:android:2065459db31e6f41ae623e',
    messagingSenderId: '114976838811',
    projectId: 'phase2-c7a65',
    storageBucket: 'phase2-c7a65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrdfZX7aJE0aWzH6KCMlzi73RPLh6cYE4',
    appId: '1:114976838811:ios:50e5f263915fd4a8ae623e',
    messagingSenderId: '114976838811',
    projectId: 'phase2-c7a65',
    storageBucket: 'phase2-c7a65.appspot.com',
    iosBundleId: 'com.example.phase2Implementation',
  );
}
