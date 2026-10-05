import 'package:flutter/material.dart';

abstract final class AppTheme {
  /// The mobileKKM brand colour.
  static const Color brand = Color(0xFF303F9F);

  /// Splash backgrounds — must match `flutter_native_splash` in pubspec.yaml.
  static const Color splashLight = Color(0xFFFFFFFF);
  static const Color splashDark = Color(0xFF121318);

  static const String _headingFont = 'Montserrat';
  static const String _bodyFont = 'Inter';

  static ThemeData light() => _build(
    ColorScheme.fromSeed(
      seedColor: brand,
      // The tonal palette would pick a slightly different indigo; keep the
      // exact brand colour for primary actions in the light theme.
      primary: brand,
      onPrimary: Colors.white,
    ),
  );

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(seedColor: brand, brightness: Brightness.dark),
  );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(colorScheme: scheme, fontFamily: _bodyFont);
    TextStyle? heading(TextStyle? style) =>
        style?.copyWith(fontFamily: _headingFont, fontWeight: FontWeight.w600);

    final text = base.textTheme;
    return base.copyWith(
      textTheme: text.copyWith(
        displayLarge: heading(text.displayLarge),
        displayMedium: heading(text.displayMedium),
        displaySmall: heading(text.displaySmall),
        headlineLarge: heading(text.headlineLarge),
        headlineMedium: heading(text.headlineMedium),
        headlineSmall: heading(text.headlineSmall),
        titleLarge: heading(text.titleLarge),
        titleMedium: heading(text.titleMedium),
        titleSmall: heading(text.titleSmall),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(
            fontFamily: _bodyFont,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
