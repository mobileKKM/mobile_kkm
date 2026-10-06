import 'package:material_ui/material_ui.dart';

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
    const AppColors(successContainer: Color(0xFFC3EFC5), onSuccessContainer: Color(0xFF0A3D16)),
  );

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(seedColor: brand, brightness: Brightness.dark),
    const AppColors(successContainer: Color(0xFF1F4D2B), onSuccessContainer: Color(0xFFBDEFC2)),
  );

  static ThemeData _build(ColorScheme scheme, AppColors colors) {
    final base = ThemeData(colorScheme: scheme, fontFamily: _bodyFont);
    TextStyle? heading(TextStyle? style) => style?.copyWith(fontFamily: _headingFont, fontWeight: FontWeight.w600);

    final text = base.textTheme;
    return base.copyWith(
      extensions: [colors],
      // Material Symbols are variable fonts: outlined unless an icon asks
      // for `fill: 1`.
      iconTheme: base.iconTheme.copyWith(fill: 0, weight: 400, opticalSize: 24),
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
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(fontFamily: _bodyFont, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}

/// Colours the Material scheme has no role for.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.successContainer, required this.onSuccessContainer});

  /// Behind a "this is in order" state, such as a valid ticket.
  final Color successContainer;
  final Color onSuccessContainer;

  static AppColors of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({Color? successContainer, Color? onSuccessContainer}) => AppColors(
    successContainer: successContainer ?? this.successContainer,
    onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
  );

  @override
  AppColors lerp(AppColors? other, double t) => other == null
      ? this
      : AppColors(
          successContainer: Color.lerp(successContainer, other.successContainer, t)!,
          onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
        );
}
