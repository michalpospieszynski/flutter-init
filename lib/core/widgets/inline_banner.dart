import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

enum BannerKind { error, info, success, warning }

/// Inline message with an icon and optional actions. Announced to screen
/// readers as a live region.
class InlineBanner extends StatelessWidget {
  const InlineBanner({
    super.key,
    required this.kind,
    required this.message,
    this.title,
    this.actions = const [],
  });

  final BannerKind kind;
  final String message;
  final String? title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.appColors;

    final (Color tone, IconData icon) = switch (kind) {
      BannerKind.error => (scheme.error, Icons.error_outline_rounded),
      BannerKind.info => (scheme.primary, Icons.info_outline_rounded),
      BannerKind.success => (colors.success, Icons.check_circle_outline),
      BannerKind.warning => (colors.warning, Icons.warning_amber_rounded),
    };

    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.control),
          border: Border.all(color: tone.withValues(alpha: 0.35)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: tone, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                  if (actions.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: actions,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
