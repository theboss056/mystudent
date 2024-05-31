import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../wrapper.dart';
import 'loginpage.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    Get.offAll(const wrapper());
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
                  topLeft: Radius.circular(700),
                  bottomLeft: Radius.circular(300),
                  bottomRight: Radius.circular(700),
                  topRight: Radius.circular(300))),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
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
                      ),
                    ],
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 300,
                      child: TextField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (() => signUp()),
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
                  child: const Text('Sign Up'),
                ),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: (() => Get.to(const loginpage())),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 16),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
