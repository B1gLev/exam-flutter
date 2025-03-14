import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class CardInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CardInputField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ez a mező nem lehet üres.';
        }
        if (value.replaceAll(" ", "").length != 16) {
          return 'Hibás kártyaszámot adtál meg.';
        }
        return null;
      },
      onChanged: (value) {
        String formattedValue = _formatCardNumber(value);
        if (controller.text != formattedValue) {
          controller.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );
        }
        if (onChanged != null) {
          onChanged!(formattedValue);
        }
      },
    );
  }

  String _formatCardNumber(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += ' ';
      formatted += digitsOnly[i];
    }
    return formatted;
  }
}
