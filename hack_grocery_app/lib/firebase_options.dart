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
    apiKey: 'AIzaSyBTF9GkdBiipyCwRYlK0JcEe1pXv-bXINI',
    appId: '1:904971790378:web:bea221b968f0b941077b53',
    messagingSenderId: '904971790378',
    projectId: 'hack-grocery',
    authDomain: 'hack-grocery.firebaseapp.com',
    storageBucket: 'hack-grocery.appspot.com',
    measurementId: 'G-HJNZL30569',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1fS4nl-b3qgTzRejIuhAG8RA4Abe70Pc',
    appId: '1:904971790378:android:56b98bab5daffb7b077b53',
    messagingSenderId: '904971790378',
    projectId: 'hack-grocery',
    storageBucket: 'hack-grocery.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAftfPdJp9iU-IyckMs51l1z-RZcOnC7D8',
    appId: '1:904971790378:ios:61339fcb56ec7cb8077b53',
    messagingSenderId: '904971790378',
    projectId: 'hack-grocery',
    storageBucket: 'hack-grocery.appspot.com',
    iosBundleId: 'com.example.hackGroceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAftfPdJp9iU-IyckMs51l1z-RZcOnC7D8',
    appId: '1:904971790378:ios:8ab3ccb19ef18061077b53',
    messagingSenderId: '904971790378',
    projectId: 'hack-grocery',
    storageBucket: 'hack-grocery.appspot.com',
    iosBundleId: 'com.example.hackGroceryApp.RunnerTests',
  );
}