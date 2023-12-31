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
    apiKey: 'AIzaSyC1nRPlHfgFWxK1vjwIiK_2pNcsG6euAsQ',
    appId: '1:294273894817:web:33c19b7b4dfe8517fc23e0',
    messagingSenderId: '294273894817',
    projectId: 'deudasql',
    authDomain: 'deudasql.firebaseapp.com',
    storageBucket: 'deudasql.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmdeQbyG2V88ecvlIevFxz561iu8TlWX0',
    appId: '1:294273894817:android:2d8891a4fa3b8121fc23e0',
    messagingSenderId: '294273894817',
    projectId: 'deudasql',
    storageBucket: 'deudasql.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa41ZTdLIozL9MR2ak_PyxLTKz-17bJww',
    appId: '1:294273894817:ios:83331af043781e66fc23e0',
    messagingSenderId: '294273894817',
    projectId: 'deudasql',
    storageBucket: 'deudasql.appspot.com',
    iosClientId: '294273894817-burkl456b830cjoscvkt6l7nv9uqp6s7.apps.googleusercontent.com',
    iosBundleId: 'com.servicios4j.deduasql',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBa41ZTdLIozL9MR2ak_PyxLTKz-17bJww',
    appId: '1:294273894817:ios:b7543e367f0a0583fc23e0',
    messagingSenderId: '294273894817',
    projectId: 'deudasql',
    storageBucket: 'deudasql.appspot.com',
    iosClientId: '294273894817-lv5js9umvadcnpto6bv5guir5qs78a75.apps.googleusercontent.com',
    iosBundleId: 'com.servicios4j.deduasql.RunnerTests',
  );
}
