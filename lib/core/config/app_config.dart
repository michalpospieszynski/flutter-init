import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// Author, app name and contact details shown in the footer, read from `base_app_config.yaml`.
/// Empty or missing values are treated as not set.
class AppConfig {
  const AppConfig({
    this.appName = '',
    this.author = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    this.linkedin = '',
    this.github = '',
    this.location = '',
  });

  static const empty = AppConfig();

  static const assetPath = 'base_app_config.yaml';

  final String appName;
  final String author;
  final String email;
  final String phone;
  final String website;
  final String linkedin;
  final String github;
  final String location;

  String nameOr(String fallback) => appName.isEmpty ? fallback : appName;

  static Future<AppConfig> load([AssetBundle? bundle]) async {
    try {
      final source = await (bundle ?? rootBundle).loadString(assetPath);
      return AppConfig.parse(source);
    } catch (_) {
      return empty;
    }
  }

  factory AppConfig.parse(String source) {
    final doc = loadYaml(source);
    if (doc is! YamlMap) return empty;

    String read(String key) => (doc[key]?.toString() ?? '').trim();

    return AppConfig(
      appName: read('app_name'),
      author: read('author'),
      email: read('email'),
      phone: read('phone'),
      website: read('website'),
      linkedin: read('linkedin'),
      github: read('github'),
      location: read('location'),
    );
  }
}
