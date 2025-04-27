import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/screens/main_page.dart';
import 'package:test_app/style/email_input_field.dart';
import 'package:test_app/style/password_input_field.dart';
import 'package:test_app/style/strings.dart';
import 'package:test_app/widgets/app_bar.dart';
import 'package:test_app/widgets/background_decoration.dart';
import 'package:test_app/widgets/error_snackbar.dart';
import 'package:test_app/widgets/succes_snackbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPageContent();
  }
}

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageContent> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonVisible = false;
  String? _errorMessage = "";

  void _checkFields() {
    setState(() {
      _isButtonVisible = _formKey.currentState!.validate();
    });
  }

  Future<Response> loginUser(String email, String password) async {
    var response = await ApiService.postRequest('auth/login', null, {"email": email, "password": password});
    if (!response.success) return response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", response.data["tokens"]["accessToken"]);
    await prefs.setString("refreshToken", response.data["tokens"]["refreshToken"]);
    return response;
  }

  Future sendForgotPassword(String email) async {
    var response = await ApiService.postRequest('auth/password/forgot', null, {"email": email});
    if (!response.success) {
      ErrorSnackBar.showErrorSnackBar(context, response.error.toString());
      return;
    }
    SuccessSnackBar.showSnackBar(context, "Elküldtük a jelszó-visszaállítási kérelmedet.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: transparentAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const BackgroundDecorationTwo(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          LoginStrings.loginMessage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          "assets/logo.png",
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        EmailInputField(
                          label: LoginStrings.email,
                          controller: emailController,
                          onChanged: (value) {
                            _checkFields();
                          },
                        ),
                        const SizedBox(height: 15),
                        PasswordNoEmptyInputField(
                          label: LoginStrings.password,
                          controller: passwordController,
                          onChanged: (value) {
                            _checkFields();
                          },
                        ),
                        if (_errorMessage != null)
                          const SizedBox(height: 5),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14
                            ),
                          ),
                        const Text("Elfelejtetted a jelszavadat?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (emailController.text.isEmpty) {
                              ErrorSnackBar.showErrorSnackBar(context, "Nem adtál meg e-mail címet.");
                              return;
                            }
                            await sendForgotPassword(emailController.text);
                          },
                          child: const Text(
                            "Kattints ide",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Visibility(
                            visible: _isButtonVisible,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () async {
                                  final result = await loginUser(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (result.code == 503) {
                                    ErrorSnackBar.showErrorSnackBar(context, result.error.toString());
                                    return;
                                  }
                                  if (result.code == 400) {
                                    setState(() {
                                      _errorMessage = result.error;
                                    });
                                    return;
                                  }
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const HomePage()),
                                  );
                                },
                                child: const Text(
                                  LoginStrings.buttonText,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
