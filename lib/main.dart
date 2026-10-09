import 'dart:async';
import 'dart:io';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/app.dart';
import 'package:mobile_kkm/core/api/device_identity.dart';
import 'package:mobile_kkm/core/api/secure_token_store.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary_cache.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();
  // Edge to edge on every Android version (15+ enforces it anyway): the
  // native splash covers the whole screen, so the Flutter one has to as well
  // or its centred logo sits higher. iOS always is.
  if (defaultTargetPlatform == TargetPlatform.android) {
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
  }

  // The screenshot protection of the ticket code outlives the app in the
  // plugin's own storage: lift it in case the app was killed with it on.
  unawaited(const ScreenSecurity().reset());

  // Kept out of iOS backups, like `allowBackup="false"` does on Android.
  const storage = FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );

  // The native splash stays up until the first frame, so resolving the
  // device identity here does not show a blank screen.
  final device = await loadDeviceIdentity(storage);
  // Not the cache directory: the system empties that when space runs short,
  // and the names would be gone offline.
  final support = await getApplicationSupportDirectory();
  await _decodeSplashLogo();

  runApp(
    ProviderScope(
      overrides: [
        deviceIdentityProvider.overrideWithValue(device),
        tokenStoreProvider.overrideWithValue(SecureTokenStore(storage)),
        userDataCacheProvider.overrideWithValue(SecureUserDataCache(storage)),
        appDatabaseProvider.overrideWithValue(AppDatabase(driftDatabase(name: 'mobile_kkm'))),
        dictionaryCacheProvider.overrideWithValue(
          FileDictionaryCache(Directory('${support.path}${Platform.pathSeparator}dictionaries')),
        ),
      ],
      child: const MobileKkmApp(),
    ),
  );
}

/// Puts the splash logo into the image cache. Without this the first frame
/// is drawn before the logo is decoded, and it visibly drops out for a moment
/// between the native splash and [SplashScreen].
Future<void> _decodeSplashLogo() {
  final done = Completer<void>();
  void finish() {
    if (!done.isCompleted) {
      done.complete();
    }
  }

  SplashScreen.logo
      .resolve(ImageConfiguration.empty)
      .addListener(ImageStreamListener((_, _) => finish(), onError: (_, _) => finish()));
  return done.future;
}

void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final font in ['Montserrat', 'Inter']) {
      yield LicenseEntryWithLineBreaks([font], await rootBundle.loadString('assets/fonts/$font-OFL.txt'));
    }
  });
}
