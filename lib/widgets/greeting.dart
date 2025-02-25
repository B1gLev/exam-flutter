import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  final String? firstName;

  const GreetingWidget({
    super.key,
    required this.firstName
  });

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreetingMessage();

    return Text(
      "$greeting $firstName,",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Az aktuális napszaknak megfelelő köszöntést ad vissza
  String _getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour < 11) {
      return "Jó reggelt"; // Délelőtti köszöntés
    } else if (hour < 18) {
      return "Jó napot"; // Délutáni köszöntés
    } else {
      return "Jó estét"; // Esti köszöntés
    }
  }
}
