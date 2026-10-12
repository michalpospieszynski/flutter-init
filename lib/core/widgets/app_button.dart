import 'package:flutter/material.dart';

enum AppButtonStyle { filled, outlined, text }

/// Button with an optional leading icon and a spinner while [busy].
/// Taps are ignored while busy, but the button keeps its normal colors.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.busy = false,
    this.style = AppButtonStyle.filled,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool busy;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final VoidCallback? tap = onPressed == null
        ? null
        : (busy ? () {} : onPressed);
    final leading = busy
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: style == AppButtonStyle.filled
                  ? scheme.onPrimary
                  : scheme.primary,
            ),
          )
        : icon;
    final text = Text(label, textAlign: TextAlign.center);

    return switch (style) {
      AppButtonStyle.filled =>
        leading == null
            ? FilledButton(onPressed: tap, child: text)
            : FilledButton.icon(onPressed: tap, icon: leading, label: text),
      AppButtonStyle.outlined =>
        leading == null
            ? OutlinedButton(onPressed: tap, child: text)
            : OutlinedButton.icon(onPressed: tap, icon: leading, label: text),
      AppButtonStyle.text =>
        leading == null
            ? TextButton(onPressed: tap, child: text)
            : TextButton.icon(onPressed: tap, icon: leading, label: text),
    };
  }
}
