import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loginpage.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email.text,
    );
  }

  String p = "";

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
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(700),
                  bottomLeft: Radius.circular(300),
                  bottomRight: Radius.circular(700),
                  topRight: Radius.circular(300))),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$p"),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Forgot Your Password ?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    decorationStyle: TextDecorationStyle.dashed,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Please enter your Email to reset !',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 300,
                    child: TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: "Enter email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      p = "check your Email";
                      reset();
                    });
                    p = "check your Email";
                    reset();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: const Text('Reset'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (() => Get.to(const loginpage())),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: const Text(' Login '),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
