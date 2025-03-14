import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class CountryInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CountryInputField(
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
        if (value!.length < 4) {
          return '4 betűnél nem lehet rövidebb.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
