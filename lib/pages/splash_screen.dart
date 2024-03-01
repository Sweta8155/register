import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registration/pages/auth/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogo();
  }
}
