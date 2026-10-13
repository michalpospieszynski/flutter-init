import '../../../core/config/app_config.dart';

enum LegalDocument {
  privacy('privacy'),
  terms('terms');

  const LegalDocument(this.slug);

  final String slug;

  /// Polish text is bundled for `pl`; every other language falls back to English.
  String assetPath(String languageCode) {
    final language = languageCode == 'pl' ? 'pl' : 'en';
    return 'assets/legal/${slug}_$language.md';
  }
}

sealed class LegalBlock {
  const LegalBlock(this.text);

  final String text;
}

final class LegalHeading extends LegalBlock {
  const LegalHeading(super.text, {required this.level});

  /// 1 for the document title, 2 for sections.
  final int level;
}

final class LegalParagraph extends LegalBlock {
  const LegalParagraph(super.text);
}

final class LegalBullet extends LegalBlock {
  const LegalBullet(super.text);
}

/// Replaces `{appName}`, `{author}` and `{email}` with values from the config.
String fillLegalPlaceholders(String source, AppConfig config) {
  return source
      .replaceAll('{appName}', config.appName)
      .replaceAll('{author}', config.author)
      .replaceAll('{email}', config.email);
}

/// Parses the small Markdown subset used by the legal documents:
/// `#` / `##` headings, `- ` bullets and plain paragraphs (one per line).
List<LegalBlock> parseLegalText(String source) {
  final blocks = <LegalBlock>[];
  for (final raw in source.split('\n')) {
    final line = raw.trim();
    if (line.isEmpty) continue;
    if (line.startsWith('## ')) {
      blocks.add(LegalHeading(line.substring(3), level: 2));
    } else if (line.startsWith('# ')) {
      blocks.add(LegalHeading(line.substring(2), level: 1));
    } else if (line.startsWith('- ')) {
      blocks.add(LegalBullet(line.substring(2)));
    } else {
      blocks.add(LegalParagraph(line));
    }
  }
  return blocks;
}
