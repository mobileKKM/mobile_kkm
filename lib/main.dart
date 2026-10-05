import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_kkm/app.dart';
import 'package:mobile_kkm/core/api/device_identity.dart';
import 'package:mobile_kkm/core/api/secure_token_store.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/features/account/services/user_data_cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();

  const storage = FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );
  // The native splash stays up until the first frame, so resolving the
  // device identity here does not show a blank screen.
  final device = await loadDeviceIdentity(storage);

  runApp(
    ProviderScope(
      overrides: [
        deviceIdentityProvider.overrideWithValue(device),
        tokenStoreProvider.overrideWithValue(SecureTokenStore(storage)),
        userDataCacheProvider.overrideWithValue(SecureUserDataCache(storage)),
      ],
      child: const MobileKkmApp(),
    ),
  );
}

void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final font in ['Montserrat', 'Inter']) {
      yield LicenseEntryWithLineBreaks([font], await rootBundle.loadString('assets/fonts/$font-OFL.txt'));
    }
  });
}
