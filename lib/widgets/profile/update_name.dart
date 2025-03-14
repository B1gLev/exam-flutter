import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/style/text_input_field.dart';
import 'package:test_app/widgets/error_snackbar.dart';
import 'package:test_app/widgets/succes_snackbar.dart';

class NameUpdateForm extends StatefulWidget {
  final VoidCallback onUpdate;
  const NameUpdateForm({super.key, required this.onUpdate});

  @override
  _NameUpdateFormState createState() => _NameUpdateFormState();
}

class _NameUpdateFormState extends State<NameUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var result = await updateName();
      if (!result.success) {
        ErrorSnackBar.showErrorSnackBar(context, "Hiba történt a frissítés során.");
        return;
      }
      SuccessSnackBar.showSnackBar(context, result.data["message"]);
      widget.onUpdate();
    }
  }

  Future<Response> updateName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text
    };
    var response = await ApiService.putRequest('user/username', token.toString(), body);
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
            "Név módosítás",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextInputField(
            label: "Új vezetéknév",
            controller: lastNameController,
          ),
          const SizedBox(height: 5),
          TextInputField(
            label: "Új keresztnév",
            controller: firstNameController,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: _submitForm,
            child: const Text(
              "Frissítés",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
