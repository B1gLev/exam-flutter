import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/registration/registration_bloc.dart';
import 'package:test_app/blocs/registration/registration_event.dart';
import 'package:test_app/screens/accounts/password_page.dart';
import 'package:test_app/style/email_input_field.dart';
import 'package:test_app/style/strings.dart';
import 'package:test_app/widgets/app_bar.dart';
import 'package:test_app/widgets/background_decoration.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmailPageContent();
  }
}

class EmailPageContent extends StatefulWidget {
  const EmailPageContent({super.key});

  @override
  State<StatefulWidget> createState() => UsernamePageState();
}

class UsernamePageState extends State<EmailPageContent> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonVisible = false;

  void _checkFields() {
    setState(() {
      _isButtonVisible = _formKey.currentState!.validate();
    });
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
                          AccountStrings.welcomeEmail,
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
                          label: AccountStrings.email,
                          controller: emailController,
                          onChanged: (value) {
                            _checkFields();
                          },
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
                                onPressed: () {
                                  final bloc = BlocProvider.of<RegistrationBloc>(
                                      context,
                                      listen: false
                                  );
                                  bloc.add(UpdateEmail(emailController.text));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: bloc,
                                        child: const PasswordPage(),
                                      ),
                                    ),
                                  );
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
