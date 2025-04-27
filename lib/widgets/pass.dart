import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/helper.dart';
import 'package:test_app/screens/order_page.dart';
import 'package:test_app/widgets/qr_code.dart';

class PassCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final int duration;
  final int id;

  const PassCard({
    super.key,
    required this.title,
    required this.price,
    required this.icon, required this.duration, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onTap: () {
          DateTime now = DateTime.now();
          DateTime validFrom = DateTime(now.year, now.month, now.day);
          DateTime validTo = validFrom.add(Duration(days: duration));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPage(id: id, title: title, price: price, validFrom: now, validTo: validTo),
            ),
          );
        },
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String date;
  final int duration;

  const TicketCard({super.key, required this.date, required this.duration});

  @override
  Widget build(BuildContext context) {
    DateTime validFrom = DateTime.parse(date);
    DateTime validTo = validFrom.add(Duration(days: duration));
    String formattedDate = DateFormat('yyyy. MM. dd').format(validTo);
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Helper.formatDuration(duration),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Érvényesség vége",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: QrCodeSheet(duration: duration),
                  ),
                );
              },
              child: const Text(
                "QR-kód mutatása",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
