import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/blocs/registration/registration_bloc.dart';
import 'package:test_app/blocs/registration/registration_state.dart';
import 'package:test_app/screens/main_page.dart';
import 'package:test_app/style/password_input_field.dart';
import 'package:test_app/style/strings.dart';
import 'package:test_app/widgets/app_bar.dart';
import 'package:test_app/widgets/background_decoration.dart';
import 'package:http/http.dart' as http;

enum CreateUserResult {
  success,
  userAlreadyExists,
  apiError
}

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PasswordPageContent();
  }
}

class PasswordPageContent extends StatefulWidget {
  const PasswordPageContent({super.key});

  @override
  State<StatefulWidget> createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPageContent>  {
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonVisible = false;
  String? _errorMessage;

  void _checkFields() {
    setState(() {
      _isButtonVisible = _formKey.currentState!.validate();
    });
  }

  void _setErrorVisible(String? value) {
    setState(() {
      _errorMessage = value;
    });
  }

  Future<CreateUserResult> createUser(String firstName, String lastName, String email, String password) async {
    var url = Uri.http('localhost:3000', 'auth/register');
    try {
      var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
          })
      );
      if (response.statusCode == 409) {
        _setErrorVisible(AccountStrings.userExists);
        return CreateUserResult.userAlreadyExists;
      }
      final json = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", json["accessToken"]);
      prefs.setString("refreshToken", json["refreshToken"]);
    } on Exception {
      _setErrorVisible(AccountStrings.apiErrorMessage);
      return CreateUserResult.apiError;
    }
    _setErrorVisible(null);
    return CreateUserResult.success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: transparentAppBar(),
      body: Padding(
        padding:
        const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const BackgroundDecorationThree(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          AccountStrings.welcomePassword,
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
                        PasswordInputField(
                          label: AccountStrings.password,
                          controller: passwordController,
                          onChanged: (value) {
                            _checkFields();
                          },
                        ),
                        const SizedBox(height: 5),
                        if (_errorMessage != null)
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12
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
                                  final bloc = BlocProvider.of<RegistrationBloc>(
                                      context,
                                      listen: false
                                  );
                                  final currentState = bloc.state;
                                  if (currentState is RegistrationValid) {
                                    final result = await createUser(
                                        currentState.firstName,
                                        currentState.lastName,
                                        currentState.email,
                                       passwordController.text
                                    );

                                    if (result == CreateUserResult.userAlreadyExists ||
                                        result == CreateUserResult.apiError) return;

                                    if (context.mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider.value(
                                            value: bloc,
                                            child: const Test(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  AccountStrings.buttonNextText,
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
