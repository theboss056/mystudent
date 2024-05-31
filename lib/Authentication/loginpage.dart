import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot_page.dart';
import 'signup_page.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isleoding = false;

  // error handling and signing function
  signIn() async {
    setState(() {
      isleoding = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error msg", e.code);
    } catch (e) {
      Get.snackbar("error msg", e.toString());
    }
    setState(() {
      isleoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isleoding
        ? const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
            )),
          )
        : Scaffold(
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
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login Page',
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
                      const Text(
                        'Please SignIn To Continue',
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
                          TextButton(
                              onPressed: (() => Get.to(const forgotpassword())),
                              child: const Text(
                                "forgot password ?",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: (() => signIn()),
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
                        child: const Text('Login'),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: (() => Get.to(const signup())),
                              child: const Text(
                                "Sign up",
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
