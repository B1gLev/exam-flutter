import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/registration/registration_bloc.dart';
import 'package:test_app/blocs/registration/registration_event.dart';
import 'package:test_app/screens/accounts/email_page.dart';
import 'package:test_app/style/strings.dart';
import 'package:test_app/style/text_input_field.dart';
import 'package:test_app/widgets/app_bar.dart';
import 'package:test_app/widgets/background_decoration.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const UsernamePageContent(),
    );
  }
}

class UsernamePageContent extends StatefulWidget {
  const UsernamePageContent({super.key});

  @override
  State<StatefulWidget> createState() => UsernamePageState();
}

class UsernamePageState extends State<UsernamePageContent> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
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
                          AccountStrings.welcomeMessage,
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
                        TextInputField(
                          label: AccountStrings.firstName,
                          controller: firstnameController,
                          onChanged: (value) {
                            _checkFields();
                          },
                        ),
                        const SizedBox(height: 15),
                        TextInputField(
                          label: AccountStrings.lastName,
                          controller: lastnameController,
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
                                  final bloc =
                                      BlocProvider.of<RegistrationBloc>(context,
                                          listen: false);
                                  bloc.add(UpdateFirstName(
                                      firstnameController.text));
                                  bloc.add(
                                      UpdateLastName(lastnameController.text));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: bloc,
                                        child: const EmailPage(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  AccountStrings.buttonText,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )),
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
