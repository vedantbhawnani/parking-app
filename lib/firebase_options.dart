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
    apiKey: 'AIzaSyCmPhvjwn29y3z7FM3Zf_7tMf1KBPilcUs',
    appId: '1:627815487648:web:67f3075945b683751e51c5',
    messagingSenderId: '627815487648',
    projectId: 'rssb-traffic-442db',
    authDomain: 'rssb-traffic-442db.firebaseapp.com',
    storageBucket: 'rssb-traffic-442db.appspot.com',
    measurementId: 'G-8NDXYRML9F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6HnMkCVlquBkvMX82UM6bTYdyE3BQkbw',
    appId: '1:627815487648:android:c96d3e695b9d27111e51c5',
    messagingSenderId: '627815487648',
    projectId: 'rssb-traffic-442db',
    storageBucket: 'rssb-traffic-442db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIQcB70ipzptJEtw8nXS1rZ8y69B0e54g',
    appId: '1:627815487648:ios:38b79bebe389d2331e51c5',
    messagingSenderId: '627815487648',
    projectId: 'rssb-traffic-442db',
    storageBucket: 'rssb-traffic-442db.appspot.com',
    iosBundleId: 'com.rssb.rssb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIQcB70ipzptJEtw8nXS1rZ8y69B0e54g',
    appId: '1:627815487648:ios:e8d6ee5541634ea61e51c5',
    messagingSenderId: '627815487648',
    projectId: 'rssb-traffic-442db',
    storageBucket: 'rssb-traffic-442db.appspot.com',
    iosBundleId: 'com.rssb.rssb.RunnerTests',
  );
}