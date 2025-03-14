import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/style/address_input.dart';
import 'package:test_app/style/country_input_field.dart';
import 'package:test_app/style/postal_code_input_field.dart';
import 'package:test_app/style/settlement_input_field.dart';
import 'package:test_app/widgets/succes_snackbar.dart';

class BillingAddressForm extends StatefulWidget {
  const BillingAddressForm({super.key});

  @override
  _BillingAddressFormState createState() => _BillingAddressFormState();
}

class _BillingAddressFormState extends State<BillingAddressForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool _existBilling = false;
  String? _errorMessage = "";

  @override
  void initState() {
    super.initState();
    getBillingDetails();
    countryController.text = "Magyarország";
  }

  void getBillingDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var response = await ApiService.getRequest('user/me', token.toString());
    if (!response.success) return;
    var billings = response.data["billings"] as List<dynamic>;
    if (billings.isNotEmpty) {
      setState(() {
        _existBilling = true;
      });
      postalCodeController.text = "${billings[0]["city"]["postalCodes"][0]["postal_code"]}";
      cityController.text = billings[0]["city"]["name"];
      addressController.text = billings[0]["address"];
    }
    return;
  }

  @override
  void dispose() {
    countryController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;
    final response = _existBilling ? await updateBillingDetail() : await addBillingDetail();
    if (!response.success) {
      setState(() => _errorMessage = response.error);
      return;
    }
    if (_errorMessage != null) setState(() => _errorMessage =  null);
    SuccessSnackBar.showSnackBar(context, response.data["message"]);
  }

  Future<Response> addBillingDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var body = {
      "country": "Hungary",
      "postalCode": int.parse(postalCodeController.text),
      "city": cityController.text,
      "address": addressController.text
    };
    var response = await ApiService.postRequest('billings/add', token.toString(), body);
    if (!response.success) return response;
    return response;
  }

  Future<Response> updateBillingDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var body = {
      "country": "Hungary",
      "postalCode": int.parse(postalCodeController.text),
      "city": cityController.text,
      "address": addressController.text
    };
    var response = await ApiService.putRequest('billings/update', token.toString(), body);
    if (!response.success) return response;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Számlázási adatok",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            "A számládon a regisztrációkor megadott név és e-mail cím fog szerepelni. Ezeket fentebb módosíthatod, ha szükséges.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          CountryInputField(
            label: "Ország",
            controller: countryController,
            onChanged: (value) {},
          ),
          const SizedBox(height: 15),
          PostalCodeInputField(
            label: "Irányítószám",
            controller: postalCodeController,
          ),
          const SizedBox(height: 15),
          SettlementInputField(
            label: "Település",
            controller: cityController,
          ),
          const SizedBox(height: 15),
          AddressInputField(
            label: "Cím",
            controller: addressController,
          ),
          const SizedBox(height: 10),
          if (_errorMessage != null) ...[
            const SizedBox(height: 5),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ],
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: _saveAddress,
            child: Text(
              _existBilling ? "Cím frissítése" : "Cím mentése",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
