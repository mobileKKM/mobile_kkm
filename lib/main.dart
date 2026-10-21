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
import 'package:mobile_kkm/core/crypto/aztec_key_store.dart';
import 'package:mobile_kkm/core/database/app_database.dart';
import 'package:mobile_kkm/core/dictionaries/dictionary_cache.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/core/providers/database_provider.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';
import 'package:mobile_kkm/features/first_start/providers/first_start_provider.dart';
import 'package:mobile_kkm/features/first_start/services/first_start_store.dart';
import 'package:mobile_kkm/features/purchase/services/last_payment_method_store.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();

  // Every screen is laid out for portrait; the manifest and Info.plist lock
  // the native side (and the splash) the same way.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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

  // The native splash stays up until the first frame, so resolving these
  // here does not show a blank screen.
  final device = await loadDeviceIdentity(storage);
  final package = await PackageInfo.fromPlatform();
  final support = await getApplicationSupportDirectory();

  // Keep track of whether the first start notice has been seen.
  final firstStart = FileFirstStartStore(File('${support.path}${Platform.pathSeparator}first_start_seen'));
  final firstStartSeen = await firstStart.read();

  // Decode the splash logo before running the app to avoid a visual glitch.
  await _decodeSplashLogo();

  runApp(
    ProviderScope(
      overrides: [
        deviceIdentityProvider.overrideWith(
          () => DeviceIdentityController(
            device.identity,
            hardwareName: device.hardwareName,
            save: ({required deviceId, required deviceName}) =>
                saveDeviceIdentity(storage, deviceId: deviceId, deviceName: deviceName),
          ),
        ),
        packageInfoProvider.overrideWithValue(package),
        firstStartSeenProvider.overrideWith(() => FirstStartController(firstStart, seen: firstStartSeen)),
        tokenStoreProvider.overrideWithValue(SecureTokenStore(storage)),
        userDataCacheProvider.overrideWithValue(SecureUserDataCache(storage)),
        lastPaymentMethodStoreProvider.overrideWithValue(SecureLastPaymentMethodStore(storage)),
        appDatabaseProvider.overrideWithValue(AppDatabase(driftDatabase(name: 'mobile_kkm'))),
        dictionaryCacheProvider.overrideWithValue(
          FileDictionaryCache(Directory('${support.path}${Platform.pathSeparator}dictionaries')),
        ),
        aztecKeyStoreProvider.overrideWithValue(
          FileAztecKeyStore(File('${support.path}${Platform.pathSeparator}aztec_key.json')),
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
