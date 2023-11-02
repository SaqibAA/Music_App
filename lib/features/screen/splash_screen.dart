import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/features/screen/dashboard.dart';

import 'auth/login.dart';
import '../../global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    void userStatus() async {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Login()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const DashBoard()));
      }
    }

    Timer(const Duration(seconds: 2), () => userStatus());

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/icon.png",
          width: width * 0.6,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

}
