import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int minLength = 5;
  final int maxLength = 20;
  final void Function(String)? onChanged;

  const TextInputField(
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
        if (value!.length < 3 || value.length > 20) {
          return 'A névnek 3 és 20 karakter között kell lennie.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
