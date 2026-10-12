import 'package:flutter_init/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig.parse', () {
    test('reads all known keys and trims values', () {
      final info = AppConfig.parse(
        'app_name: " Demo "\nauthor: Ada\nemail: ada@example.com\n'
        'phone: "+48 123"\nwebsite: example.com\nlinkedin: in/ada\n'
        'github: gh/ada\nlocation: Warsaw\n',
      );

      expect(info.appName, 'Demo');
      expect(info.author, 'Ada');
      expect(info.email, 'ada@example.com');
      expect(info.phone, '+48 123');
      expect(info.website, 'example.com');
      expect(info.linkedin, 'in/ada');
      expect(info.github, 'gh/ada');
      expect(info.location, 'Warsaw');
    });

    test('treats missing and blank values as empty', () {
      final info = AppConfig.parse('author: Ada\nemail: ""\nphone:\n');

      expect(info.email, isEmpty);
      expect(info.phone, isEmpty);
      expect(info.github, isEmpty);
    });

    test('returns an empty config for non-map documents', () {
      expect(AppConfig.parse('- just\n- a list').author, isEmpty);
      expect(AppConfig.parse('').author, isEmpty);
    });
  });

  test('nameOr falls back only when app_name is empty', () {
    expect(AppConfig.empty.nameOr('Default'), 'Default');
    expect(const AppConfig(appName: 'Mine').nameOr('Default'), 'Mine');
  });
}
