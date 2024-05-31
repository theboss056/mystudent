import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../wrapper.dart';

class verify extends StatefulWidget {
  const verify({super.key});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  sendverifylink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) => Get.snackbar(
          'link sent',
          'a link has been send to your email',
          margin: const EdgeInsets.all(5),
        ));
  }

  reload() async {
    await FirebaseAuth.instance.currentUser!
        .reload()
        .then((value) => Get.offAll(const wrapper()));
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
        Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Verify Email',
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
                        color: Colors.black38),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Verification link has been sent to your mail',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (() => reload()),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                shadowColor: Colors.blue,
              ),
              child: const Text('Reload'),
            ),
          ],
        ),
      ]),
    );
  }
}
