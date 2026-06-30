// lib/firebase_options.dart
// ✅ REPLACE the values below with YOUR Firebase project config
// Go to: Firebase Console → Project Settings → Your Apps → Web App → SDK Setup

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
      default:
        return web;
    }
  }

  // ✅ REPLACE with your Firebase Web config values
  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyARbVBquRHmGtzv6H19LJ_bVC8E9RRJX28",
      authDomain: "todo-app-version1.firebaseapp.com",
      projectId: "todo-app-version1",
      storageBucket: "todo-app-version1.firebasestorage.app",
      messagingSenderId: "188028639150",
      appId: "1:188028639150:web:c53d36574f269a88a21a3f",
      measurementId: "G-HKVM7FC3Z4");

  // ✅ REPLACE with your Firebase Android config values
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
  );

  // ✅ REPLACE with your Firebase iOS config values
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );
}
