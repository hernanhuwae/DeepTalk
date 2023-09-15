import 'dart:async';

import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/prestart');
    });
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(left: 50),
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('gambar/DeepTalk.png'))),
          )
        ]),
      ),
    );
  }
}
