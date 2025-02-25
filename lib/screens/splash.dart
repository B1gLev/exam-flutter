import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/screens/no_internet.dart';
import 'package:test_app/screens/welcome.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkInternetAndNavigate();
  }

  Future<void> _checkInternetAndNavigate() async {
    final result = await Connectivity().checkConnectivity();
    Get.offAll(() => result == ConnectivityResult.none ? const NoInternetPage() : const Welcome());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
