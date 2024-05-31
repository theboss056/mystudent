import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Center(
            child: Container(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 200,
                  ),
                  Center(
                    child: Text(
                      'Profile',
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
                  Text("data")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
