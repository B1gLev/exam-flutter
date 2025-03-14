import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/screens/main_page.dart';
import 'package:test_app/style/payment/card_holder_input.dart';
import 'package:test_app/style/payment/card_input.dart';
import 'package:test_app/style/payment/cvv_input.dart';
import 'package:test_app/style/payment/expiration_input.dart';
import 'package:test_app/widgets/background_decoration.dart';
import 'package:test_app/widgets/error_snackbar.dart';
import 'package:test_app/widgets/succes_snackbar.dart';

class OrderPage extends StatelessWidget {
  final int id;
  final String title;
  final String price;
  final DateTime validFrom;
  final DateTime validTo;

  const OrderPage({
    super.key,
    required this.title,
    required this.price,
    required this.validFrom,
    required this.validTo, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return OrderPageContent(
      title: title,
      price: price,
      validFrom: validFrom,
      validTo: validTo, id: id,
    );
  }
}

class OrderPageContent extends StatefulWidget {
  final int id;
  final String title;
  final String price;
  final DateTime validFrom;
  final DateTime validTo;

  const OrderPageContent({
    super.key,
    required this.title,
    required this.price,
    required this.validFrom,
    required this.validTo, required this.id,
  });

  @override
  State<StatefulWidget> createState() => OrderState();
}

class OrderState extends State<OrderPageContent> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy. MM. dd.');

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: Stack(
          children: [
            const BackgroundDecorationThree(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Vásárlás",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bérlet neve",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Érvényesség kezdete",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${dateFormat.format(widget.validFrom)} (ma) - ${dateFormat.format(widget.validTo)} (eddig)",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: paymentSheet(),
                      ),
                    );
                  },
                  child: Text('Fizetés'),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget paymentSheet() {
    final _formKey = GlobalKey<FormState>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Fizetéshez add meg a kártya adataidat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              CardInputField(
                label: "Kártya szám",
                controller: TextEditingController(),
              ),
              const SizedBox(height: 15),
              CardHolderInputField(
                label: "Kártya tulajdonos",
                controller: TextEditingController(),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ExpirationInputField(
                      label: "Lejárat (Hó/Év)",
                      controller: TextEditingController(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CVVInputField(
                      label: "CVV",
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor: Colors.black87,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(color: Colors.green),
                                  SizedBox(height: 16),
                                  Text(
                                    "Fizetés folyamatban...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pop(context);

                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        var token = prefs.get("accessToken");
                        var result = await ApiService.postRequest(
                          'payments/finish',
                          token.toString(),
                          {"passId": widget.id, "methodId": 1, "autorenewer": false},
                        );

                        if (!result.success) {
                          Navigator.pop(context);
                          ErrorSnackBar.showErrorSnackBar(context, result.error.toString());
                          return;
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                        SuccessSnackBar.showSnackBar(context, result.data["message"]);
                      },
                      child: const Text(
                        "Fizetés folytatása",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Mégse",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        )
      ),
    );
  }
}