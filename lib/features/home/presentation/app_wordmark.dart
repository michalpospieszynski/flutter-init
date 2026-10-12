import 'package:flutter/material.dart';

import '../../../core/app_scope.dart';
import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_tokens.dart';

/// Logo mark plus app name, used as the app bar title.
class AppWordmark extends StatelessWidget {
  const AppWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: context.appColors.brandGradient,
          ),
          child: const Icon(Icons.bolt_rounded, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(AppScope.of(context).config.nameOr(context.l10n.appName)),
      ],
    );
  }
}
