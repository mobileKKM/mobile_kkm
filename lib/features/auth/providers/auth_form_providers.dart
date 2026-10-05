import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

/// `auth/password-policy` — drives the password checklist.
final passwordPolicyProvider = FutureProvider.autoDispose<PasswordPolicy>(
  (ref) => ref.watch(ekpClientProvider).auth.passwordPolicy(),
  retry: (_, _) => null,
);

/// `auth/marketing-consents` — the registration checkboxes.
final marketingConsentsProvider =
    FutureProvider.autoDispose<List<MarketingConsent>>((ref) async {
      final response = await ref
          .watch(ekpClientProvider)
          .auth
          .marketingConsents();
      return response.marketingConsents;
    }, retry: (_, _) => null);
