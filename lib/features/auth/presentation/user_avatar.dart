import 'package:flutter/material.dart';

import '../domain/auth_service.dart';

/// Profile photo, falling back to initials on the brand gradient.
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user, this.radius = 28});

  final AuthUser user;
  final double radius;

  String get _initials {
    final parts = user.label
        .split(RegExp(r'[\s@.]+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    final first = parts.first[0];
    final second = parts.length > 1 ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl;
    final fallback = Text(
      _initials,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: radius * 0.7,
      ),
    );

    return Semantics(
      label: user.label,
      image: true,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
          ),
        ),
        child: photo == null
            ? fallback
            : Image.network(
                photo,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => fallback,
              ),
      ),
    );
  }
}
