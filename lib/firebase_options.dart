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
    apiKey: 'AIzaSyAbmDxnuUDLsIjaL1WD9lQoQw2AuT48UKU',
    appId: '1:126757254250:web:c385451914ef049b980613',
    messagingSenderId: '126757254250',
    projectId: 'chitchat-4b58c',
    authDomain: 'chitchat-4b58c.firebaseapp.com',
    storageBucket: 'chitchat-4b58c.appspot.com',
    measurementId: 'G-C1EEJ9188D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOgfpRybTg545vekX5xx-GonwgbbmIuPE',
    appId: '1:126757254250:android:7cfaa351a394ee3f980613',
    messagingSenderId: '126757254250',
    projectId: 'chitchat-4b58c',
    storageBucket: 'chitchat-4b58c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDA_q6VBseBagnbLp-KMpR3-4cASGc61Ss',
    appId: '1:126757254250:ios:8329e661d1f3698f980613',
    messagingSenderId: '126757254250',
    projectId: 'chitchat-4b58c',
    storageBucket: 'chitchat-4b58c.appspot.com',
    iosClientId: '126757254250-olelojh73222s0kppaq8kp3ejbpecbv0.apps.googleusercontent.com',
    iosBundleId: 'com.example.chitChat',
  );
}