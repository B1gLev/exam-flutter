import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class ExpirationInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const ExpirationInputField({
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
        if (value.length == 5 && int.parse(value.split("/")[0]) > 12 ||
            value.length == 5 && int.parse(value.split("/")[1]) < 25) {
          return "A kártyája lejárati éve \nlejárt.";
        }
        return null;
      },
      onChanged: (value) {
        if (value.length == 2) controller.text = "$value/";
      },
    );
  }
}
