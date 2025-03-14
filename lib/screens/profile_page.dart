import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/api.dart';
import 'package:test_app/helper.dart';
import 'package:test_app/screens/welcome.dart';
import 'package:test_app/widgets/app_bar.dart';
import 'package:test_app/widgets/background_decoration.dart';
import 'package:test_app/widgets/profile/add_billing.dart';
import 'package:test_app/widgets/profile/update_email.dart';
import 'package:test_app/widgets/profile/update_name.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePageContent();
  }
}

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePageContent> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<Response> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("accessToken");
    var response = await ApiService.getRequest('user/me', token.toString());
    if (!response.success) return response;
    setState(() {
      firstName = response.data["firstName"];
      lastName = response.data["lastName"];
      email = response.data["email"];
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    String initials = Helper.getInitials(lastName, firstName);

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
              const BackgroundDecorationFour(),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initials,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$lastName $firstName",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "$email",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("accessToken");
                          prefs.remove("refreshToken");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Welcome()),
                          );
                        },
                        child: const Text(
                          "Kijelentkezés",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NameUpdateForm(
                            onUpdate: () async {
                              getUser();
                            },
                          ),
                          const SizedBox(height: 60),
                          EmailUpdateForm(
                            onUpdate: () async {
                              getUser();
                            },
                          ),
                          const SizedBox(height: 60),
                          const BillingAddressForm(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



