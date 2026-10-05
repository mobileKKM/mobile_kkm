import 'package:ekp_api/ekp_api.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// User-facing text for a failed API call.
///
/// Server-provided messages are shown as-is (the API only returns Polish).
String describeError(AppLocalizations l10n, Object error) {
  return switch (error) {
    EkpNetworkException() => l10n.errorNetwork,
    EkpApiException(:final message?) when message.isNotEmpty => message,
    _ => l10n.errorGeneric,
  };
}
