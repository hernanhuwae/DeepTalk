import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dechat/chatpage.dart';
import 'package:dechat/sharing/tema.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homechatDeeptalk extends StatefulWidget {
  const homechatDeeptalk({super.key});

  @override
  State<homechatDeeptalk> createState() => _homechatDeeptalkState();
}

class _homechatDeeptalkState extends State<homechatDeeptalk> {
  final FirebaseAuth authHome = FirebaseAuth.instance;
  var cariNama = '';

  void signOut() async {
    await authHome
        .signOut()
        .then((value) => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 29,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 65),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HELLO ,',
                        style: teksputih2.copyWith(
                            fontSize: 20, fontWeight: extrabold),
                      ),
                      Text(
                        authHome.currentUser!.email!,
                        style: tekspink2.copyWith(
                            fontSize: 15, fontWeight: extrabold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 34, right: 18),
                width: 55,
                height: 53,
                child: IconButton(
                    onPressed: signOut,
                    icon: Icon(
                      Icons.exit_to_app,
                      color: pink,
                      size: 35,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 34, right: 18),
                  width: 55,
                  height: 53,
                  decoration:
                      BoxDecoration(color: pink, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person_2_outlined,
                        color: putih,
                        size: 30,
                      ))),
            ],
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26),
            width: double.infinity,
            height: 43,
            decoration: BoxDecoration(
                color: putih, borderRadius: BorderRadius.circular(20)),
            child: TextField(
              //Todo: Buat Search Bar
              onChanged: (value) {
                setState(() {
                  cariNama = value;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                    color: pink,
                  ),
                  hintStyle: tekspink,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: InputBorder.none,
                  hintText: 'pencarian...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 45),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RANDOM PEOPLE',
                      style: tekspink2.copyWith(
                          fontSize: 25, fontWeight: extrabold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        'Pilih lawan bicaramu secara acak dan mulai ngobrol lebih Deep!',
                        style: teksputih2.copyWith(
                            fontSize: 10, fontWeight: medium),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('deeptalk')
                  .orderBy('anonim')
                  .startAt([cariNama]).endAt([cariNama + '\uf8ff']).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Ada Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Sedang Loading');
                }
                return Expanded(
                    child: ListView(
                        children: snapshot.data!.docs
                            .map<Widget>((doc) => _UserCard(doc))
                            .toList()));
              })
        ]),
      ),
    );
  }

  Widget _UserCard(DocumentSnapshot dokumen) {
    Map<String, dynamic> myData = dokumen.data()! as Map<String, dynamic>;

    //todo: Tampilkan semua user kecuali userCurrent
    if (authHome.currentUser!.email != myData['email']) {
      return Card(
        margin: EdgeInsets.only(
          top: 10,
        ),
        color: hitam,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDeepTalk(
                        PenerimaUserEmail: myData['email'],
                        Uid: myData['uid'],
                        PenerimaAnonim: myData['anonim'])));
          },
          child: ListTile(
            leading: Container(
              width: 60,
              height: 55,
              decoration: BoxDecoration(
                  color: putih,
                  border: Border.all(width: 2, color: pink),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('gambar/man.png'),
                  )),
            ),
            title: Text(
              myData['anonim'],
              style: teksputih2.copyWith(fontSize: 16, fontWeight: extrabold),
            ),
            subtitle: Text(
              myData['email'],
              style: tekspink2.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
