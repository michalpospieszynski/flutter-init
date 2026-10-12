import 'package:flutter/material.dart';

import '../localization/l10n_extension.dart';

/// Text field with an optional show/hide toggle for passwords.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.obscure = false,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.onSubmitted,
    this.fieldKey,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final bool obscure;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: widget.obscure && _hidden,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.obscure
            ? IconButton(
                tooltip: _hidden
                    ? l10n.authShowPassword
                    : l10n.authHidePassword,
                icon: Icon(
                  _hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );
  }
}
