import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const EmailInputField(
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
        final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
        if (!emailRegex.hasMatch(value!)) {
          return "Érvénytelen e-mail cím.";
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
