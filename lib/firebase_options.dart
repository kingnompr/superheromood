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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:web:placeholder',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    authDomain: 'superhero-moods-b2662.firebaseapp.com',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:android:1b88f6b9213f24a8fd0c1e',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:ios:placeholder',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
    iosBundleId: 'com.example.superheromood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:macos:placeholder',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
    iosBundleId: 'com.example.superheromood',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:windows:placeholder',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyBqP0gnxqlloDcPLVc3QbWgghj1DPrrNSo',
    appId: '1:795282018363:linux:placeholder',
    messagingSenderId: '795282018363',
    projectId: 'superhero-moods-b2662',
    storageBucket: 'superhero-moods-b2662.firebasestorage.app',
  );
}
