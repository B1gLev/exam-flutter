import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_app/screens/welcome.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoInternetPageContent();
  }
}

class NoInternetPageContent extends StatefulWidget {
  const NoInternetPageContent({super.key});
  @override
  State<StatefulWidget> createState() => NoInternetState();
}

class NoInternetState extends State<NoInternetPageContent> {
  Future<void> _checkInternetAndNavigate() async {
    final result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) Get.offAll(() => const Welcome());
  }

  Future<void> _handleRefresh() async {
    await _checkInternetAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
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
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Oppá.. Bzz BzZ..",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Úgy tűnik nincs megfelelő internetkapcsolatod.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Csatlakozz Wifi-re vagy mobilnethez.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Frissítéshez húzd lefelé.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}