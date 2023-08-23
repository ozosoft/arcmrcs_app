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
    apiKey: 'AIzaSyDvwNmASYHTrqhcY00KOTFlB_ntLByMdxw',
    appId: '1:756507339207:web:adf543c829f480a423d1e2',
    messagingSenderId: '756507339207',
    projectId: 'quiz-lab-f9e22',
    authDomain: 'quiz-lab-f9e22.firebaseapp.com',
    storageBucket: 'quiz-lab-f9e22.appspot.com',
    measurementId: 'G-HQ1FF4L0VC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkkzPYATMfiWIKyRVfn3EqLDXdZ85Q0Sg',
    appId: '1:756507339207:android:f7fe66f16e7c8c6c23d1e2',
    messagingSenderId: '756507339207',
    projectId: 'quiz-lab-f9e22',
    storageBucket: 'quiz-lab-f9e22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjFp0css7ZjMy5i9LveuSzVO4OH_onwJA',
    appId: '1:756507339207:ios:494cca4f1822a0c923d1e2',
    messagingSenderId: '756507339207',
    projectId: 'quiz-lab-f9e22',
    storageBucket: 'quiz-lab-f9e22.appspot.com',
    androidClientId: '756507339207-al6uohh0khqteh1c1jlj4c12fem0voc7.apps.googleusercontent.com',
    iosClientId: '756507339207-fqqhbp7aeadm2hckh6l40ca3bm5ogmhi.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterPrime',
  );
}
