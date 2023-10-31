import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mento/helpers/dialogs.dart';
import 'package:mento/main.dart';
import 'package:mento/screens/home_page.dart';

import '../../api/apis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _handleGooogleBtnClick() {
    //  for showing progress bar

    Dialogs.showProgressNar(context);
    _signInWithGoogle().then((user) async {
      //for hiding progress bar

      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditonalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log("\n_signInWithGoogle: $e");
      // ignore: use_build_context_synchronously
      Dialogs.showSnackbar(
          context, 'Something went wrong. Check internet Connection');
      return null;
    }
  }

  @override
  Widget build(context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          56.0,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.2),
              title: const Text(
                'Welcome to Mentee',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              elevation: 0.0,
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_fluid.png"),
                fit: BoxFit.cover,
                opacity: 97),
          ),
        ),
        Positioned(
            top: mq.height * .25,
            width: mq.width * .30,
            left: mq.width * .35,
            child: Image.asset('assets/images/mentoring.png')),
        Positioned(
            bottom: mq.height * .25,
            width: mq.width * .9,
            left: mq.width * .05,
            height: mq.height * .07,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 233, 255, 187),
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                _handleGooogleBtnClick();
              },
              icon: Image.asset(
                'assets/images/g1.png',
                height: mq.height * .04,
              ),
              label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                    TextSpan(text: 'Sign up with '),
                    TextSpan(
                        text: 'Google',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ))
      ]),
    );
  }
}
