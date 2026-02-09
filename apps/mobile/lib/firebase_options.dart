import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGh46tT92A-K1VgfjW2ix1Ssiwrpyzt20',
    appId: '1:1027788176486:android:40c36ab57ac5e4141281a7',
    messagingSenderId: '1027788176486',
    projectId: 'shelfie-development-484809',
    storageBucket: 'shelfie-development-484809.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ4rqkwUoBN1SSMiHpK2prxeOYh5nAhYE',
    appId: '1:1027788176486:ios:b0bc533acbad71ae1281a7',
    messagingSenderId: '1027788176486',
    projectId: 'shelfie-development-484809',
    storageBucket: 'shelfie-development-484809.firebasestorage.app',
    iosBundleId: 'app.shelfie.shelfie',
  );
}
