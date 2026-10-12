import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Centers content, caps its width and makes it scrollable.
class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Short fade and upward slide when first shown. Skipped when the platform
/// asks to reduce motion.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * 16),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
