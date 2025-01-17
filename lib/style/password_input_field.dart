import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class PasswordInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int minLength = 5;
  final int maxLength = 20;
  final void Function(String)? onChanged;

  const PasswordInputField(
      {super.key,
        required this.label,
        required this.controller,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      controller: controller,
      validator: (value) {
        if (value!.length < 8) {
          return 'A jelszavadnak minimum 8 karakter hosszúnak\nkell lennie.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
