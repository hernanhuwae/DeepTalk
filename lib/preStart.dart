import 'package:dechat/sharing/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PreStartDeepTalkPage extends StatelessWidget {
  const PreStartDeepTalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff111111),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 22, right: 22, top: 70, bottom: 68),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('gambar/prestart.png'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'OBROLAN SERIUS DENGAN SIAPAPUN',
                textAlign: TextAlign.center,
                style: tekspink.copyWith(
                  fontWeight: extrabold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Bagikan keluh kesahmu dengan siapapun secara',
              style: teksputih,
            ),
            Text(
              'bebas dan terbuka dengan identittas anonim ',
              style: teksputih,
            ),
            Text(
              'dengan lawan bicaramu',
              style: teksputih,
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 142),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: putih, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'MULAI',
                    style:
                        tekspink.copyWith(fontSize: 15, fontWeight: extrabold),
                  )),
            )
          ],
        ));
  }
}
