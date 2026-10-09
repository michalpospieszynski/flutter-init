import 'package:flutter/material.dart';

/// Minimal, neutral Material 3 theme with a single indigo accent.
abstract final class AppTheme {
  static const Color _seed = Color(0xFF4F46E5);
  static const double _radius = 14;

  static ThemeData get light => _build(
    ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
      surface: Colors.white,
    ).copyWith(surfaceContainerLowest: const Color(0xFFF8F8FA)),
    background: const Color(0xFFF8F8FA),
  );

  static ThemeData get dark => _build(
    ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
      surface: const Color(0xFF16161A),
    ),
    background: const Color(0xFF0F0F12),
  );

  static ThemeData _build(ColorScheme scheme, {required Color background}) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_radius),
    );
    const buttonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 18);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: shape, padding: buttonPadding),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: shape,
          padding: buttonPadding,
          side: BorderSide(color: scheme.outlineVariant),
          foregroundColor: scheme.onSurface,
        ),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
      textTheme: Typography.material2021().black.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
    );
  }
}
