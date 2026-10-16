import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/demo/demo_data.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';

/// Whether the screens show a made-up person instead of the user, for
/// screenshots and recordings. Only the debug menu turns it on, and only
/// until the app is closed: it is not stored.
class DemoMode extends Notifier<bool> {
  @override
  bool build() => false;

  void set(bool enabled) => state = enabled;
}

final demoModeProvider = NotifierProvider<DemoMode, bool>(DemoMode.new);

/// [userDataProvider] as the screens show it: in demo mode with the
/// placeholders of [demoUserData]. For display only; whatever goes into a
/// request reads [userDataProvider].
final shownUserDataProvider = Provider<AsyncValue<UserDataResponse?>>((ref) {
  final data = ref.watch(userDataProvider);
  return ref.watch(demoModeProvider) ? data.whenData(demoUserData) : data;
});
