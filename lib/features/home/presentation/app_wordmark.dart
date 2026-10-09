import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';

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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
          ),
          child: const Icon(Icons.bolt_rounded, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(context.l10n.appName),
      ],
    );
  }
}
