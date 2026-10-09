import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  /// The mobileKKM brand colour.
  static const Color brand = Color(0xFF303F9F);

  /// Splash backgrounds — must match `flutter_native_splash` in pubspec.yaml.
  static const Color splashLight = Color(0xFFFFFFFF);
  static const Color splashDark = Color(0xFF121318);

  static const String _headingFont = 'Montserrat';
  static const String _bodyFont = 'Inter';

  // The scheme is Material's "fidelity" variant of the brand colour. The
  // roles the design names are pinned below, so that they do not drift with
  // the library; the rest come from the same algorithm.

  static ThemeData light() => _build(
    ColorScheme.fromSeed(seedColor: brand, dynamicSchemeVariant: DynamicSchemeVariant.fidelity).copyWith(
      // The generated primary is a darker indigo; primary actions keep the
      // exact brand colour. It equals primaryContainer, so on brand surfaces
      // use the fixed roles, never primary.
      primary: brand,
      onPrimary: const Color(0xFFFFFFFF),
      secondary: const Color(0xFF575C82),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFCDD1FF),
      onSecondaryContainer: const Color(0xFF54597F),
      tertiary: const Color(0xFF582300),
      error: const Color(0xFFBA1A1A),
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF93000A),
      surface: const Color(0xFFFBF8FF),
      onSurface: const Color(0xFF1B1B21),
      onSurfaceVariant: const Color(0xFF454652),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF5F2FB),
      surfaceContainer: const Color(0xFFEFEDF6),
      surfaceContainerHigh: const Color(0xFFE9E7F0),
      surfaceContainerHighest: const Color(0xFFE3E1EA),
      outline: const Color(0xFF767683),
      outlineVariant: const Color(0xFFC6C5D4),
      inverseSurface: const Color(0xFF303037),
      onInverseSurface: const Color(0xFFF2EFF8),
    ),
    const AppColors(
      success: Color(0xFF2F694E),
      onSuccess: Color(0xFFFFFFFF),
      successContainer: Color(0xFFB2F0CE),
      onSuccessContainer: Color(0xFF002113),
    ),
  );

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(
      seedColor: brand,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      primary: const Color(0xFFBBC3FF),
      onPrimary: const Color(0xFF112286),
      secondary: const Color(0xFFBFC4F0),
      onSecondary: const Color(0xFF282E51),
      secondaryContainer: const Color(0xFF41466C),
      onSecondaryContainer: const Color(0xFFB1B6E1),
      tertiary: const Color(0xFFFFB68F),
      error: const Color(0xFFFFB4AB),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      surface: const Color(0xFF121319),
      onSurface: const Color(0xFFE3E1EA),
      onSurfaceVariant: const Color(0xFFC6C5D4),
      surfaceContainerLowest: const Color(0xFF0D0E14),
      surfaceContainerLow: const Color(0xFF1B1B21),
      surfaceContainer: const Color(0xFF1F1F25),
      surfaceContainerHigh: const Color(0xFF292930),
      surfaceContainerHighest: const Color(0xFF34343B),
      outline: const Color(0xFF8F8F9E),
      outlineVariant: const Color(0xFF454652),
      inverseSurface: const Color(0xFFE3E1EA),
      onInverseSurface: const Color(0xFF303037),
    ),
    const AppColors(
      success: Color(0xFF97D4B3),
      onSuccess: Color(0xFF003824),
      successContainer: Color(0xFF125138),
      onSuccessContainer: Color(0xFFB2F0CE),
    ),
  );

  /// A button inside a dialog: lower than the app's 56 dp buttons.
  static final ButtonStyle dialogAction = FilledButton.styleFrom(
    minimumSize: const Size(0, 40),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    textStyle: const TextStyle(fontFamily: _bodyFont, fontSize: 14, fontWeight: FontWeight.w600),
  );

  static ThemeData _build(ColorScheme generated, AppColors colors) {
    // The same in both themes: a ticket that can be shown looks the same
    // day and night.
    final scheme = generated.copyWith(
      primaryContainer: brand,
      onPrimaryContainer: const Color(0xFFAAB4FF),
      primaryFixed: const Color(0xFFDFE0FF),
      primaryFixedDim: const Color(0xFFBBC3FF),
      onPrimaryFixed: const Color(0xFF000D5F),
      onPrimaryFixedVariant: const Color(0xFF2D3C9C),
      tertiaryContainer: const Color(0xFF7B3400),
      onTertiaryContainer: const Color(0xFFFFA26E),
      tertiaryFixed: const Color(0xFFFFDBCA),
      onTertiaryFixed: const Color(0xFF331100),
      scrim: Colors.black,
    );
    final base = ThemeData(colorScheme: scheme, fontFamily: _bodyFont);

    TextStyle heading(double size, double lineHeight, {double spacing = 0}) => TextStyle(
      fontFamily: _headingFont,
      fontWeight: FontWeight.w600,
      fontSize: size,
      height: lineHeight / size,
      letterSpacing: spacing,
    );
    TextStyle body(double size, double lineHeight, FontWeight weight) => TextStyle(
      fontFamily: _bodyFont,
      fontWeight: weight,
      fontSize: size,
      height: lineHeight / size,
      letterSpacing: 0,
    );

    final text = base.textTheme
        .merge(
          TextTheme(
            displayLarge: heading(57, 64, spacing: -1),
            displayMedium: heading(45, 52),
            displaySmall: heading(36, 44),
            headlineLarge: heading(32, 40),
            headlineMedium: heading(28, 36),
            headlineSmall: heading(24, 32),
            titleLarge: heading(22, 28),
            titleMedium: heading(18, 24),
            titleSmall: heading(14, 20),
            bodyLarge: body(16, 24, FontWeight.w400),
            bodyMedium: body(14, 20, FontWeight.w400),
            bodySmall: body(12, 16, FontWeight.w400),
            labelLarge: body(14, 20, FontWeight.w600),
            labelMedium: body(12, 16, FontWeight.w500),
            labelSmall: body(11, 16, FontWeight.w500),
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    const buttonText = TextStyle(fontFamily: _bodyFont, fontSize: 16, fontWeight: FontWeight.w600);
    const buttonSize = Size(64, 56);
    const buttonPadding = EdgeInsets.symmetric(horizontal: 24);
    final disabledFill = scheme.onSurface.withValues(alpha: 0.12);
    final disabledContent = scheme.onSurface.withValues(alpha: 0.38);
    final fieldBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(16));

    return base.copyWith(
      extensions: [colors],
      scaffoldBackgroundColor: scheme.surface,
      // Material Symbols are variable fonts: outlined unless an icon asks
      // for `fill: 1`.
      iconTheme: base.iconTheme.copyWith(fill: 0, weight: 400, opticalSize: 24),
      textTheme: text,
      appBarTheme: AppBarTheme(
        toolbarHeight: 64,
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: text.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: fieldBorder,
        enabledBorder: fieldBorder.copyWith(borderSide: BorderSide(color: scheme.outline)),
        helperStyle: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        errorStyle: text.bodySmall?.copyWith(color: scheme.error),
        helperMaxLines: 2,
        errorMaxLines: 2,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
          iconSize: 22,
          textStyle: buttonText,
          disabledBackgroundColor: disabledFill,
          disabledForegroundColor: disabledContent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
          iconSize: 22,
          textStyle: buttonText,
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontFamily: _bodyFont, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        extendedTextStyle: buttonText,
        extendedPadding: const EdgeInsetsDirectional.only(start: 20, end: 24),
        extendedIconLabelSpacing: 10,
        shape: const StadiumBorder(),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        iconColor: scheme.secondary,
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        modalBackgroundColor: scheme.surfaceContainerLow,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        dragHandleColor: scheme.onSurfaceVariant.withValues(alpha: 0.4),
        dragHandleSize: const Size(32, 4),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: text.bodyMedium?.copyWith(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: scheme.secondaryContainer,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return text.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
          );
        }),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        headerHeadlineStyle: text.headlineLarge,
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, thickness: 1, space: 1),
    );
  }
}

/// Colours the Material scheme has no role for: "this is in order", such as
/// a valid ticket. Always shown with an icon and a word, never alone.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  /// For the "Valid" label on the indigo ticket; like Material's fixed
  /// roles, the same in both themes.
  Color get successFixed => const Color(0xFFB2F0CE);
  Color get onSuccessFixed => const Color(0xFF002113);

  static AppColors of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({Color? success, Color? onSuccess, Color? successContainer, Color? onSuccessContainer}) =>
      AppColors(
        success: success ?? this.success,
        onSuccess: onSuccess ?? this.onSuccess,
        successContainer: successContainer ?? this.successContainer,
        onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      );

  @override
  AppColors lerp(AppColors? other, double t) => other == null
      ? this
      : AppColors(
          success: Color.lerp(success, other.success, t)!,
          onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
          successContainer: Color.lerp(successContainer, other.successContainer, t)!,
          onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
        );
}
