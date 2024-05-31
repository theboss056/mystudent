import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Authentication/loginpage.dart';
import 'Authentication/verify_email.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data!.emailVerified) {
            return const Homepage();
          } else {
            return const verify();
          }
        } else {
          return const loginpage();
        }
      },
    ));
  }
}
