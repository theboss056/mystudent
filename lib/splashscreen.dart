import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'wrapper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.leanBack); // Hides status and navigation bars
    Future.delayed(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const wrapper()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Homepage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(500),
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(500),
                  topRight: Radius.circular(200))),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Center(
                  child: Text(
                    'MY STUDENTS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      decorationStyle: TextDecorationStyle.dashed,
                      letterSpacing: 2.0,
                      wordSpacing: 4.0,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/mystudents.png"),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Made In Bharat with ❤️',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    decorationStyle: TextDecorationStyle.dashed,
                    letterSpacing: 2.0,
                    wordSpacing: 4.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
