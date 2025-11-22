import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ANDROID
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1b0uEdeq8KYT4Udd8JR1X52Ty4ecjVfk',
    appId: '1:688735371092:android:14272ddcf64e44bd7852c1',
    messagingSenderId: '688735371092',
    projectId: 'dishcovery-be4a2',
    storageBucket: 'dishcovery-be4a2.firebasestorage.app',
  );

  // IOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTlKdbS23jCGMTmXb5D_ytbsigGs2q_M',
    appId: '1:688735371092:ios:f9c4dac4c890683a7852c1',
    messagingSenderId: '688735371092',
    projectId: 'dishcovery-be4a2',
    storageBucket: 'dishcovery-be4a2.firebasestorage.app',
    iosBundleId: 'com.example.dishcovery',
  );

  // WEB
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAv40pBJXj56tGFEZD6fjV81x-JavOT98Q",
    authDomain: "dishcovery-be4a2.firebaseapp.com",
    projectId: "dishcovery-be4a2",
    storageBucket: "dishcovery-be4a2.firebasestorage.app",
    messagingSenderId: "688735371092",
    appId: "1:688735371092:web:2517d5c856490a547852c1",
    measurementId: "G-5R5HWJE2WC",
  );
}
