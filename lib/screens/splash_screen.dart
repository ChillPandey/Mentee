import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mento/api/apis.dart';
import 'package:mento/main.dart';
import 'package:mento/screens/auth/login_page.dart';
import 'package:mento/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (APIs.auth.currentUser != null) {
        log("\nUser: ${APIs.auth.currentUser}");
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //media query for taking the data about the screen size
    mq = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Positioned(
            top: mq.height * .25,
            width: mq.width * .30,
            left: mq.width * .35,
            child: Image.asset('assets/images/mentoring.png')),
        Positioned(
            bottom: mq.height * .25,
            width: mq.width,
            child: const Text(
              textAlign: TextAlign.center,
              "MADE WITH ♥",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: .5),
            ))
      ]),
    );
  }
}
