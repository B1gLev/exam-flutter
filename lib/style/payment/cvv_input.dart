import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class CVVInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CVVInputField({
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
        if (value.length > 3) {
          return 'Helytelen formátum.';
        }
        return null;
      },
      onChanged: (value) {
        final numericValue = value.replaceAll(RegExp(r'\D'), '');
        controller.value = TextEditingValue(
          text: numericValue,
          selection: TextSelection.collapsed(offset: numericValue.length),
        );

        if (onChanged != null) {
          onChanged!(numericValue);
        }
      }
    );
  }

}
