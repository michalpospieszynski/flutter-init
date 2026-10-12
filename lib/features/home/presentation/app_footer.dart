import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_scope.dart';
import '../../../core/config/app_config.dart';
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
    final config = AppScope.of(context).config;

    final links = Wrap(
      alignment: WrapAlignment.end,
      spacing: 4,
      runSpacing: 0,
      children: [
        _FooterLink(label: l10n.footerPrivacy, uri: AppLinks.privacyPolicy),
        _FooterLink(label: l10n.footerTerms, uri: AppLinks.termsOfService),
        ..._contactLinks(config),
      ],
    );

    final copyrightParts = [
      if (config.author.isNotEmpty)
        l10n.footerCopyright(DateTime.now().year.toString(), config.author),
      if (config.location.isNotEmpty) config.location,
    ];
    final copyright = Text(
      copyrightParts.join(' · '),
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

List<Widget> _contactLinks(AppConfig c) {
  String bare(String url) =>
      url.replaceFirst(RegExp(r'^https?://(www\.)?'), '');
  Uri web(String url) =>
      Uri.parse(url.startsWith('http') ? url : 'https://$url');
  return [
    if (c.email.isNotEmpty)
      _FooterLink(
        label: c.email,
        uri: Uri(scheme: 'mailto', path: c.email),
      ),
    if (c.phone.isNotEmpty)
      _FooterLink(
        label: c.phone,
        uri: Uri(scheme: 'tel', path: c.phone.replaceAll(' ', '')),
      ),
    if (c.website.isNotEmpty)
      _FooterLink(label: bare(c.website), uri: web(c.website)),
    if (c.linkedin.isNotEmpty)
      _FooterLink(label: 'LinkedIn', uri: web(c.linkedin)),
    if (c.github.isNotEmpty) _FooterLink(label: 'GitHub', uri: web(c.github)),
  ];
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
