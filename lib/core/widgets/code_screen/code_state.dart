import 'package:ekp_api/ekp_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What the code area of a [CodeScreen] has to show.
sealed class CodeState {
  const CodeState();
}

/// A code is on its way.
final class CodeLoading extends CodeState {
  const CodeLoading();
}

/// There is a code, and its time is running.
sealed class CodeRunning extends CodeState {
  const CodeRunning({required this.id, required this.secondsLeft, required this.lifetime});

  /// From here on the ring is drawn as a warning.
  static const lowSeconds = 15;

  /// Tells one code from the next: a new one starts with a full ring.
  final Object id;
  final int secondsLeft;

  /// All of the code's time, in seconds.
  final int lifetime;

  /// The share of the code's time still ahead.
  double get left => lifetime <= 0 ? 0 : (secondsLeft / lifetime).clamp(0, 1);

  /// The same a second from now: where the ring is heading meanwhile.
  double get leftNext => lifetime <= 0 ? 0 : ((secondsLeft - 1) / lifetime).clamp(0, 1);

  bool get low => secondsLeft <= lowSeconds;

  /// The time left as `m:ss`.
  String get time => '${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}';
}

/// The code, to be scanned.
final class CodeShown extends CodeRunning {
  const CodeShown({required super.id, required super.secondsLeft, required super.lifetime, required this.code});

  /// Black on transparent; it is laid on a white panel.
  final Widget code;
}

/// There is a code, but the screen is being recorded or mirrored (iOS).
final class CodeHidden extends CodeRunning {
  const CodeHidden({required super.id, required super.secondsLeft, required super.lifetime});
}

/// There is no code and none on its way.
final class CodeFailed extends CodeState {
  const CodeFailed(this.message);

  /// Why: the server's own wording, or the app's.
  final String message;
}

/// Why there is no code, for [CodeFailed]: what the server said, word for
/// word (Polish only), and the app's own sentence when it said nothing or
/// did not answer.
String codeProblem(AppLocalizations l10n, Object? error) => switch (error) {
  final String message when message.isNotEmpty => message,
  EkpNetworkException() => l10n.ticketControlError,
  EkpApiException(:final message?) when message.isNotEmpty => message,
  _ => l10n.ticketControlError,
};
