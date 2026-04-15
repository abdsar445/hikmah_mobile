import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // We only need Android for this specific build
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBczMTfZJvlZHB1k1XZhRhGZ80nzip2f8',
    appId: '1:249707689492:android:3d6983f9b71d7324c85901',
    messagingSenderId: '249707689492',
    projectId: 'hikmah-1ba38',
    storageBucket: 'hikmah-1ba38.firebasestorage.app',
  );
}
