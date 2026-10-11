import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';

void main() {
  test('the ticket code is protected unless the debug menu switches it off', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(screenSecurityProvider), isNot(isA<NoScreenSecurity>()));

    container.read(screenSecurityEnabledProvider.notifier).set(false);
    final off = container.read(screenSecurityProvider);
    expect(off, isA<NoScreenSecurity>());
    // Nothing to protect and nothing to report.
    await off.setSecure(true);
    expect(await off.captured.isEmpty, isTrue);

    container.read(screenSecurityEnabledProvider.notifier).set(true);
    expect(container.read(screenSecurityProvider), isNot(isA<NoScreenSecurity>()));
  });
}
