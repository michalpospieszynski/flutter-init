import 'package:flutter/material.dart';

/// Spacing scale (4pt grid).
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double section = 72;
}

abstract final class AppRadius {
  static const double control = 14;
  static const double card = 20;
  static const double chip = 100;
}

abstract final class AppBreakpoints {
  /// Side-by-side hero and navigation rail.
  static const double wide = 820;

  /// Two-column feature grid.
  static const double medium = 520;

  static const double maxContentWidth = 1040;
}

/// Brand colors that Material's [ColorScheme] has no slot for.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.accent,
    required this.success,
    required this.warning,
    required this.brandGradient,
  });

  final Color accent;
  final Color success;
  final Color warning;
  final Gradient brandGradient;

  @override
  AppColors copyWith({
    Color? accent,
    Color? success,
    Color? warning,
    Gradient? brandGradient,
  }) {
    return AppColors(
      accent: accent ?? this.accent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      brandGradient: brandGradient ?? this.brandGradient,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      brandGradient: Gradient.lerp(brandGradient, other.brandGradient, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
