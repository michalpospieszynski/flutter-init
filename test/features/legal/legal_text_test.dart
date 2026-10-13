import 'dart:io';

import 'package:flutter_init/core/config/app_config.dart';
import 'package:flutter_init/features/legal/domain/legal_document.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LegalDocument.assetPath', () {
    test('uses Polish text only for pl', () {
      expect(
        LegalDocument.privacy.assetPath('pl'),
        'assets/legal/privacy_pl.md',
      );
      expect(LegalDocument.terms.assetPath('en'), 'assets/legal/terms_en.md');
      expect(LegalDocument.terms.assetPath('de'), 'assets/legal/terms_en.md');
    });
  });

  group('fillLegalPlaceholders', () {
    test('replaces app name, author and email', () {
      const config = AppConfig(
        appName: 'Demo',
        author: 'Jane Doe',
        email: 'jane@example.com',
      );
      final result = fillLegalPlaceholders(
        '{appName} by {author}, {email}',
        config,
      );
      expect(result, 'Demo by Jane Doe, jane@example.com');
    });

    test('all bundled documents contain only known placeholders', () async {
      final bundled = [
        for (final doc in LegalDocument.values)
          for (final lang in ['en', 'pl']) doc.assetPath(lang),
      ];
      for (final path in bundled) {
        final source = await _readAsset(path);
        final unknown = RegExp(r'\{(\w+)\}')
            .allMatches(source)
            .map((m) => m.group(1))
            .where((k) => !const {'appName', 'author', 'email'}.contains(k));
        expect(unknown, isEmpty, reason: path);
      }
    });
  });

  group('parseLegalText', () {
    test('maps headings, bullets and paragraphs', () {
      final blocks = parseLegalText('''
# Title

Intro line.

## Section
- first
- second
''');

      expect(blocks, hasLength(5));
      expect(blocks[0], isA<LegalHeading>());
      expect((blocks[0] as LegalHeading).level, 1);
      expect((blocks[1] as LegalParagraph).text, 'Intro line.');
      expect((blocks[2] as LegalHeading).level, 2);
      expect(blocks[3], isA<LegalBullet>());
      expect(blocks[3].text, 'first');
    });
  });
}

Future<String> _readAsset(String path) => File(path).readAsString();
