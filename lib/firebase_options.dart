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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsWGel3w6NAnzJC9mB7No4hvYo_nVJumo',
    appId: '1:484581939575:android:90b0cbb4e569055f8b2972',
    messagingSenderId: '484581939575',
    projectId: 'mentee-3a86f',
    storageBucket: 'mentee-3a86f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdS2nx5XnhlmPd9zG39t6-Nw0a8WkexI4',
    appId: '1:484581939575:ios:0225b3cc4fed0c278b2972',
    messagingSenderId: '484581939575',
    projectId: 'mentee-3a86f',
    storageBucket: 'mentee-3a86f.appspot.com',
    androidClientId: '484581939575-umgamkjmbhnb29a7ppk60brf54a7ka1f.apps.googleusercontent.com',
    iosClientId: '484581939575-hqj9fah7q0cbpb3o4sct1ll0mee7b0mo.apps.googleusercontent.com',
    iosBundleId: 'com.example.mento',
  );
}
