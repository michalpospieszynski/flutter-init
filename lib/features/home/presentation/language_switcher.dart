import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/localization/locale_controller.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key, required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;
    final l10n = context.l10n;

    return Semantics(
      label: l10n.languageLabel,
      child: SegmentedButton<String>(
        showSelectedIcon: false,
        style: const ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        segments: [
          ButtonSegment(
            value: 'en',
            label: const Text('EN'),
            tooltip: l10n.languageEnglish,
          ),
          ButtonSegment(
            value: 'pl',
            label: const Text('PL'),
            tooltip: l10n.languagePolish,
          ),
        ],
        selected: {current},
        onSelectionChanged: (selection) =>
            controller.setLocale(Locale(selection.first)),
      ),
    );
  }
}
