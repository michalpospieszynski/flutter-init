import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/app_links.dart';
import '../../../core/localization/l10n_extension.dart';

/// Standard footer: legal links and contact on one side, copyright on the other.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    final links = Wrap(
      alignment: WrapAlignment.end,
      spacing: 4,
      runSpacing: 0,
      children: [
        _FooterLink(label: l10n.footerPrivacy, uri: AppLinks.privacyPolicy),
        _FooterLink(label: l10n.footerTerms, uri: AppLinks.termsOfService),
        _FooterLink(label: l10n.footerContact, uri: AppLinks.contact),
      ],
    );

    final copyright = Text(
      l10n.footerCopyright(DateTime.now().year, l10n.appName),
      style: theme.textTheme.bodySmall?.copyWith(color: muted),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [links, const SizedBox(height: 8), copyright],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: copyright),
                const SizedBox(width: 24),
                Flexible(child: links),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.uri});

  final String label;
  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: () => launchUrl(uri),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.onSurfaceVariant,
        textStyle: theme.textTheme.bodySmall,
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(label),
    );
  }
}
