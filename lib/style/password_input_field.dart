import 'package:flutter/material.dart';
import 'package:test_app/style/input_field.dart';

class PasswordInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const PasswordInputField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'A jelszónak minimum 8 karakter hosszúnak kell lennie.';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.white70,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}

class PasswordNoEmptyInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const PasswordNoEmptyInputField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  _PasswordNoEmptyInputFieldState createState() => _PasswordNoEmptyInputFieldState();
}

class _PasswordNoEmptyInputFieldState extends State<PasswordNoEmptyInputField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nem lehet üres ez a mező.';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.white70,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}
