import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kReleaseMode;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return kReleaseMode ? _prodAndroid : _devAndroid;
      case TargetPlatform.iOS:
        return kReleaseMode ? _prodIos : _devIos;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // --- dev (shelfie-development-484809) ---

  static const FirebaseOptions _devAndroid = FirebaseOptions(
    apiKey: 'AIzaSyBGh46tT92A-K1VgfjW2ix1Ssiwrpyzt20',
    appId: '1:1027788176486:android:f131ad148b50e6421281a7',
    messagingSenderId: '1027788176486',
    projectId: 'shelfie-development-484809',
    storageBucket: 'shelfie-development-484809.firebasestorage.app',
  );

  static const FirebaseOptions _devIos = FirebaseOptions(
    apiKey: 'AIzaSyDAnoFr7PMDKSBpXjNoBxMwLXKTnZCdTOM',
    appId: '1:1027788176486:ios:752624ba4201ff8d1281a7',
    messagingSenderId: '1027788176486',
    projectId: 'shelfie-development-484809',
    storageBucket: 'shelfie-development-484809.firebasestorage.app',
    iosBundleId: 'app.shelfie.shelfie.dev',
  );

  // --- prod (shelfie-production-485714) ---

  static const FirebaseOptions _prodAndroid = FirebaseOptions(
    apiKey: 'AIzaSyDvgg2bNepD-ouMqRdcHG8-S-MrVXKPV9E',
    appId: '1:1054694254363:android:106264feb44d57829d15be',
    messagingSenderId: '1054694254363',
    projectId: 'shelfie-production-485714',
    storageBucket: 'shelfie-production-485714.firebasestorage.app',
  );

  static const FirebaseOptions _prodIos = FirebaseOptions(
    apiKey: 'AIzaSyDYjMnc8yiZ3ZJUYYOX8ueVCLcgtdeVXy0',
    appId: '1:1054694254363:ios:ec70bd5f84d14ef69d15be',
    messagingSenderId: '1054694254363',
    projectId: 'shelfie-production-485714',
    storageBucket: 'shelfie-production-485714.firebasestorage.app',
    iosBundleId: 'app.shelfie.shelfie',
  );
}
