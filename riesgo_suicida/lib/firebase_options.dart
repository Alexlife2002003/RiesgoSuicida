// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiKeyWeb = dotenv.env['API_KEY_WEB'] ?? "NO-API";
String appIdWeb = dotenv.env['APP_ID_WEB'] ?? "NO-API";
String messagingSenderId = dotenv.env['MESSAGING_SENDER_ID'] ?? "NO-API";
String projectId = dotenv.env['PROJECT_ID'] ?? "NO-API";

String authDomain = dotenv.env['AUTH_DOMAIN'] ?? "NO-API";
String storageBucket = dotenv.env['STORAGE_BUCKET'] ?? "NO-API";
String measurementId= dotenv.env['MEASUREMENT_ID'] ?? "NO-API";
String apiKeyAndroid = dotenv.env['API_KEY_ANDROID'] ?? "NO-API";

String appIdAndroid = dotenv.env['APP_ID_ANDROID'] ?? "NO-API";
String apiKeyIosMacos = dotenv.env['API_KEY_IOS_MACOS'] ?? "NO-API";
String appIdIosMacos= dotenv.env['APP_ID_IOS_MACOS'] ?? "NO-API";
String iosClientIdMacos = dotenv.env['IOS_cLIENT_ID_MACOS'] ?? "NO-API";


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

  static  FirebaseOptions web = FirebaseOptions(
    apiKey: apiKeyWeb,
    appId: appIdWeb,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    authDomain: authDomain,
    storageBucket: storageBucket,
    measurementId: measurementId,
  );

  static  FirebaseOptions android = FirebaseOptions(
    apiKey: apiKeyAndroid,
    appId: appIdAndroid,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
  );

  static  FirebaseOptions ios = FirebaseOptions(
    apiKey: apiKeyIosMacos,
    appId: appIdIosMacos,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
    iosClientId:
        iosClientIdMacos,
    iosBundleId: 'com.example.riesgoSuicida',
  );

  static  FirebaseOptions macos = FirebaseOptions(
    apiKey: apiKeyIosMacos,
    appId: appIdIosMacos,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    storageBucket: storageBucket,
    iosClientId:
        iosClientIdMacos,
    iosBundleId: 'com.example.riesgoSuicida',
  );
}
