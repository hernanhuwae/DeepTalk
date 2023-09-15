import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dechat/sharing/formText.dart';
import 'package:dechat/sharing/tema.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DaftarDeeptalk extends StatefulWidget {
  const DaftarDeeptalk({super.key});

  @override
  State<DaftarDeeptalk> createState() => _DaftarDeeptalkState();
}

class _DaftarDeeptalkState extends State<DaftarDeeptalk> {
  final FirebaseFirestore myCloud = FirebaseFirestore.instance;
  final FirebaseAuth myDaftarAuth = FirebaseAuth.instance;
  final TextEditingController _anonimNameDaftar = TextEditingController();
  final TextEditingController _emailDaftar = TextEditingController();
  final TextEditingController _passwordDaftar = TextEditingController();

  void myDaftar(String emailku, String passku, String anonim) async {
    UserCredential? kredensialRegister;
    try {
      kredensialRegister = await myDaftarAuth.createUserWithEmailAndPassword(
          email: emailku, password: passku);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: 'Mohon Lengkapi data dibawah',
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.7));
    }

    if (kredensialRegister != null) {
      String myUid = kredensialRegister.user!.uid;
      myCloud.collection('deeptalk').doc(myUid).set({
        'anonim': anonim,
        'email': emailku,
        'password': passku,
        'uid': kredensialRegister.user!.uid,
      }).then((value) => Navigator.pushNamedAndRemoveUntil(
          context, '/login', (route) => false));
    }
  }

  @override
  void dispose() {
    _anonimNameDaftar.dispose();
    _emailDaftar.dispose();
    _passwordDaftar.dispose();
    super.dispose();
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
                        'DAFTAR',
                        style: tekspink.copyWith(
                            fontSize: 35, fontWeight: extrabold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Daftarkan akun anda untuk memulai obrolan yang lebih Deep!',
                        style: teksputih.copyWith(
                            fontSize: 8, fontWeight: extrabold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            deeptalkForm(
                hide: false,
                kontroller: _anonimNameDaftar,
                teksform: 'Anonim Name',
                icons: Icon(
                  Icons.person,
                  color: pink,
                  size: 30,
                )),
            SizedBox(
              height: 42,
            ),
            deeptalkForm(
                hide: false,
                kontroller: _emailDaftar,
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
                hide: true,
                kontroller: _passwordDaftar,
                teksform: 'Password',
                icons: Icon(
                  Icons.lock,
                  color: pink,
                  size: 30,
                )),
            Container(
              margin:
                  EdgeInsets.only(left: 142, right: 142, top: 50, bottom: 50),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: putih, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    myDaftar(_emailDaftar.text, _passwordDaftar.text,
                        _anonimNameDaftar.text);
                  },
                  child: Text(
                    'DAFTAR',
                    style:
                        tekspink.copyWith(fontSize: 14, fontWeight: extrabold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
