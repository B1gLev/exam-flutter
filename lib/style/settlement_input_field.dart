import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class SettlementInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const SettlementInputField(
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
        final RegExp nameRegExp = RegExp(r"^[a-zA-ZáéíóöőúüűÁÉÍÓÖŐÚÜŰ\s-]+$");
        if (value == null || value.isEmpty) {
          return 'Nem lehet üres ez a mező.';
        }
        if (value.length < 2) {
          return 'Az településnek minimum 2 karakterből kell állnia.';
        }
        if (!nameRegExp.hasMatch(value)) {
          return 'A település neve csak betűket, szóközt és \nkötőjelet tartalmazhat.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
