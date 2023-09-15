import 'package:dechat/Daftar.dart';
import 'package:dechat/Login.dart';
import 'package:dechat/homechat.dart';
import 'package:dechat/preStart.dart';
import 'package:dechat/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DeepTalk());
}

class DeepTalk extends StatelessWidget {
  const DeepTalk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => splashscreen(),
        '/prestart': (context) => PreStartDeepTalkPage(),
        '/daftar': (context) => DaftarDeeptalk(),
        '/login': (context) => LoginDeeptalk(),
        '/homechat': (context) => homechatDeeptalk(),
      },
    );
  }
}
