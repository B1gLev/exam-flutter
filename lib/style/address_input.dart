import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class AddressInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const AddressInputField(
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
        return null;
      },
      onChanged: onChanged,
    );
  }
}
