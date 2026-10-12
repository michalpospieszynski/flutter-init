import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// "Indigo Aurora" Material 3 theme. To rebrand, change the colors below.
abstract final class AppTheme {
  static const Color _brandPrimary = Color(0xFF4F46E5);
  static const Color _brandSecondary = Color(0xFF7C3AED);
  static const String _fontFamily = 'Inter';

  /// Built once and reused, so theme changes never rebuild the [ThemeData].
  static final ThemeData light = _buildLight();

  static ThemeData _buildLight() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _brandPrimary,
          brightness: Brightness.light,
        ).copyWith(
          primary: _brandPrimary,
          onPrimary: Colors.white,
          secondary: _brandSecondary,
          onSecondary: Colors.white,
          tertiary: const Color(0xFF0E7490),
          surface: Colors.white,
          onSurface: const Color(0xFF14141A),
          onSurfaceVariant: const Color(0xFF52525E),
          surfaceContainerLowest: const Color(0xFFF8F8FA),
          surfaceContainerLow: const Color(0xFFF3F3F7),
          surfaceContainer: const Color(0xFFEFEFF4),
          outlineVariant: const Color(0xFFDDDDE5),
        );
    return _build(
      scheme,
      background: const Color(0xFFF8F8FA),
      colors: const AppColors(
        accent: Color(0xFF0E7490),
        success: Color(0xFF15803D),
        warning: Color(0xFFB45309),
        brandGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandPrimary, _brandSecondary],
        ),
      ),
    );
  }

  static final ThemeData dark = _buildDark();

  static ThemeData _buildDark() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _brandPrimary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF818CF8),
          onPrimary: const Color(0xFF12103A),
          secondary: const Color(0xFFA78BFA),
          onSecondary: const Color(0xFF1B0F3F),
          tertiary: const Color(0xFF22D3EE),
          surface: const Color(0xFF16161A),
          onSurface: const Color(0xFFF2F2F5),
          onSurfaceVariant: const Color(0xFFA3A3B0),
          surfaceContainerLowest: const Color(0xFF0F0F12),
          surfaceContainerLow: const Color(0xFF131317),
          surfaceContainer: const Color(0xFF1C1C21),
          outlineVariant: const Color(0xFF2B2B33),
        );
    return _build(
      scheme,
      background: const Color(0xFF0F0F12),
      colors: const AppColors(
        accent: Color(0xFF22D3EE),
        success: Color(0xFF4ADE80),
        warning: Color(0xFFFBBF24),
        brandGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandPrimary, _brandSecondary],
        ),
      ),
    );
  }

  static ThemeData _build(
    ColorScheme scheme, {
    required Color background,
    required AppColors colors,
  }) {
    final control = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.control),
    );
    const buttonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 18);
    final base = ThemeData(
      brightness: scheme.brightness,
      fontFamily: _fontFamily,
      useMaterial3: true,
    );
    final text = base.textTheme
        .copyWith(
          displaySmall: base.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            height: 1.1,
          ),
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: color, width: width),
        );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: text,
      extensions: [colors],
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.8)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: control,
          padding: buttonPadding,
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: control,
          padding: buttonPadding,
          side: BorderSide(color: scheme.outlineVariant),
          foregroundColor: scheme.onSurface,
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: control,
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: border(scheme.outlineVariant),
        enabledBorder: border(scheme.outlineVariant),
        focusedBorder: border(scheme.primary, 2),
        errorBorder: border(scheme.error),
        focusedErrorBorder: border(scheme.error, 2),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          shape: control,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: 0.16),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: background,
        indicatorColor: scheme.primary.withValues(alpha: 0.16),
        selectedIconTheme: IconThemeData(color: scheme.primary),
        selectedLabelTextStyle: text.labelMedium?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: text.labelMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: control,
      ),
      listTileTheme: ListTileThemeData(shape: control),
    );
  }
}
