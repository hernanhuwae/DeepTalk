import 'dart:math';
import 'package:dechat/sharing/formText.dart';
import 'package:dechat/sharing/tema.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginDeeptalk extends StatefulWidget {
  const LoginDeeptalk({super.key});
  @override
  State<LoginDeeptalk> createState() => _LoginDeeptalkState();
}

class _LoginDeeptalkState extends State<LoginDeeptalk> {
  final FirebaseAuth myAuth = FirebaseAuth.instance;
  final TextEditingController _emaiilLogin = TextEditingController();
  final TextEditingController _paswordLogin = TextEditingController();

  void myLogin(String myEmail, String myPass) async {
    UserCredential? mykredensial;

    try {
      mykredensial = await myAuth.signInWithEmailAndPassword(
          email: myEmail, password: myPass);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: 'Email dan Password tidak cocok',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.7));
    }

    if (mykredensial != null) {
      String myUid = mykredensial.user!.uid;
      print('Berhasil LOGIN');
      Navigator.pushNamed(context, '/homechat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 55, right: 55, top: 56, bottom: 19),
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('gambar/daflogpage.png'))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 75, top: 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: tekspink.copyWith(
                            fontSize: 35, fontWeight: extrabold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Siap memulai obrolan dengan nuansa lebih unik dan lebih Deep!',
                        style: teksputih.copyWith(
                            fontSize: 8, fontWeight: extrabold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 59,
            ),
            deeptalkForm(
                hide: false,
                kontroller: _emaiilLogin,
                teksform: 'Email',
                icons: Icon(
                  Icons.mail,
                  color: pink,
                  size: 30,
                )),
            SizedBox(
              height: 42,
            ),
            deeptalkForm(
                kontroller: _paswordLogin,
                hide: true,
                teksform: 'Password',
                icons: Icon(
                  Icons.lock,
                  color: pink,
                  size: 30,
                )),
            Container(
              margin:
                  EdgeInsets.only(left: 142, right: 142, top: 50, bottom: 60),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: putih, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    myLogin(_emaiilLogin.text, _paswordLogin.text);
                  },
                  child: Text(
                    'LOGIN',
                    style:
                        tekspink.copyWith(fontSize: 14, fontWeight: extrabold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: teksputih.copyWith(fontSize: 10),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/daftar');
                      },
                      child: Text(
                        'Daftar',
                        style: tekspink.copyWith(fontSize: 11),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
