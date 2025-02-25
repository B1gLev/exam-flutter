import 'package:flutter/material.dart';

class PassWidget extends StatelessWidget {
  final int duration;
  final int price;

  const PassWidget({
    super.key,
    required this.duration,
    required this.price
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(duration == 30 ? "Havi bérlet" : "Napi bérlet",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text("$price Ft",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 35),
            const Row(
              children: [
                Text("Vásárlás",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward, size: 15, color: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
