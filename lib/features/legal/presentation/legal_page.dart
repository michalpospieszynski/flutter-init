import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_scope.dart';
import '../../../core/config/app_config.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/page_body.dart';
import '../domain/legal_document.dart';

/// Shows a legal document as a subpage. The text comes from `assets/legal`.
class LegalPage extends StatefulWidget {
  const LegalPage({super.key, required this.document});

  final LegalDocument document;

  @override
  State<LegalPage> createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  Future<List<LegalBlock>>? _content;
  String? _languageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == _languageCode) return;
    _languageCode = languageCode;
    _content = _load(
      widget.document.assetPath(languageCode),
      AppScope.of(context).config,
    );
  }

  Future<List<LegalBlock>> _load(String path, AppConfig config) async {
    final source = await rootBundle.loadString(path);
    return parseLegalText(fillLegalPlaceholders(source, config));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = switch (widget.document) {
      LegalDocument.privacy => l10n.legalPrivacy,
      LegalDocument.terms => l10n.legalTerms,
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<List<LegalBlock>>(
        future: _content,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(l10n.legalLoadError));
          }
          final blocks = snapshot.data;
          if (blocks == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return PageBody(
            child: SelectionArea(
              child: _LegalBody(blocks: blocks),
            ),
          );
        },
      ),
    );
  }
}

class _LegalBody extends StatelessWidget {
  const _LegalBody({required this.blocks});

  final List<LegalBlock> blocks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final body = theme.textTheme.bodyMedium?.copyWith(height: 1.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final block in blocks)
          Padding(
            padding: EdgeInsets.only(
              top: block is LegalHeading && block.level == 2
                  ? AppSpacing.lg
                  : AppSpacing.sm,
            ),
            child: switch (block) {
              LegalHeading(:final text, :final level) => Text(
                text,
                style: level == 1
                    ? theme.textTheme.headlineSmall
                    : theme.textTheme.titleMedium,
              ),
              LegalBullet(:final text) => Padding(
                padding: const EdgeInsets.only(left: AppSpacing.sm),
                child: Text('•  $text', style: body),
              ),
              LegalParagraph(:final text) => Text(text, style: body),
            },
          ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
