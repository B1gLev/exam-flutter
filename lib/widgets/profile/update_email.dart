import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/style/email_input_field.dart';
import 'package:test_app/widgets/error_snackbar.dart';
import 'package:test_app/widgets/succes_snackbar.dart';

class EmailUpdateForm extends StatefulWidget {
  final VoidCallback onUpdate;
  const EmailUpdateForm({super.key, required this.onUpdate});

  @override
  _EmailUpdateFormState createState() => _EmailUpdateFormState();
}

class _EmailUpdateFormState extends State<EmailUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var result = await updateEmail();
      if (!result.success) {
        ErrorSnackBar.showErrorSnackBar(context, "Hiba történt a frissítés során.");
        return;
      }
      SuccessSnackBar.showSnackBar(context, result.data["message"]);
      widget.onUpdate();
    }
  }

  Future<Response> updateEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var body = {
      "email": emailController.text,
    };
    var response = await ApiService.patchRequest('user/email', token.toString(), body);
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
            "E-mail módosítás",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          EmailInputField(
            label: "Add meg az új e-mail címedet",
            controller: emailController,
            onChanged: (value) {},
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
