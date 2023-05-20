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
    apiKey: 'AIzaSyBTwkyEQgDj1pC3IjyqvSnmsFLPjhcD_uU',
    appId: '1:754115010094:web:fd07a05949576bb50dc9bf',
    messagingSenderId: '754115010094',
    projectId: 'proyecto2-19400657',
    authDomain: 'proyecto2-19400657.firebaseapp.com',
    storageBucket: 'proyecto2-19400657.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrH8dMdaGPdnebvqtAKkYLiTRs1im8F90',
    appId: '1:754115010094:android:807b3726926f326d0dc9bf',
    messagingSenderId: '754115010094',
    projectId: 'proyecto2-19400657',
    storageBucket: 'proyecto2-19400657.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsH555GxmVSsAWIjqLZUDN2ln7JLTWJnc',
    appId: '1:754115010094:ios:cef41017075e02e30dc9bf',
    messagingSenderId: '754115010094',
    projectId: 'proyecto2-19400657',
    storageBucket: 'proyecto2-19400657.appspot.com',
    iosClientId: '754115010094-jbifjudg3dett2gkbqjpu4l4j057r1ie.apps.googleusercontent.com',
    iosBundleId: 'mx.edu.ittepic.damU4Proyecto219400657',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsH555GxmVSsAWIjqLZUDN2ln7JLTWJnc',
    appId: '1:754115010094:ios:aa77e93554c9a7ec0dc9bf',
    messagingSenderId: '754115010094',
    projectId: 'proyecto2-19400657',
    storageBucket: 'proyecto2-19400657.appspot.com',
    iosClientId: '754115010094-b4f34nqcvktbq11a71r03tramg3l8od3.apps.googleusercontent.com',
    iosBundleId: 'mx.edu.ittepic.damU4Proyecto219400657.RunnerTests',
  );
}