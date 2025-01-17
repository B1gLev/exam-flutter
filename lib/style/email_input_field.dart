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
        if (!value!.contains("@")) {
          return "Érvénytelen email cím.";
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
