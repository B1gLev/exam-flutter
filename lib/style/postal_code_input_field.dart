import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class PostalCodeInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const PostalCodeInputField(
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
        if (value == null || value.isEmpty) {
          return 'Nem lehet üres ez a mező.';
        }
        if (value.length > 4) {
          return 'Az irányítószám maximum 4 karakter lehet.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
