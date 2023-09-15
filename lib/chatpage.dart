import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dechat/chat/kustomKotakPesan.dart';
import 'package:dechat/chat/service.dart';
import 'package:dechat/sharing/tema.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDeepTalk extends StatefulWidget {
  final String PenerimaUserEmail;
  final String Uid;
  final String PenerimaAnonim;
  const ChatDeepTalk(
      {super.key,
      required this.PenerimaUserEmail,
      required this.Uid,
      required this.PenerimaAnonim});

  @override
  State<ChatDeepTalk> createState() => _ChatDeepTalkState();
}

class _ChatDeepTalkState extends State<ChatDeepTalk> {
  final ScrollController _scrollOtomatis = ScrollController();
  final TextEditingController pesanKontroller = TextEditingController();
  final FirebaseAuth authChat = FirebaseAuth.instance;
  final DeepTalkChatService _deepTalkChatService = DeepTalkChatService();

  void kirimPesan() async {
    if (pesanKontroller.text.isNotEmpty) {
      await _deepTalkChatService.kirimPesan(widget.Uid, pesanKontroller.text);
      pesanKontroller.clear();
    }
  }

  void scrollBawah() {
    _scrollOtomatis.animateTo(_scrollOtomatis.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hitam,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/homechat');
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: pink,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Container(
                  width: 55,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: pink),
                      shape: BoxShape.circle,
                      image:
                          DecorationImage(image: AssetImage('gambar/man.png'))),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.PenerimaAnonim,
                      style: teksputih2.copyWith(
                          fontSize: 18, fontWeight: extrabold),
                    ),
                    Text(widget.PenerimaUserEmail,
                        style: tekspink2.copyWith(
                            fontSize: 14, fontWeight: medium))
                  ],
                ),
              ),
              IconButton(
                  onPressed: scrollBawah,
                  icon: Icon(
                    Icons.arrow_downward,
                    color: pink,
                    size: 30,
                  ))
            ]),
          ),
          Expanded(
            child: _PesanList(),
          ),
          _CustomInputPesan(),
        ],
      )),
    );
  }

  Widget _PesanList() {
    return StreamBuilder(
      stream:
          _deepTalkChatService.getPesan(widget.Uid, authChat.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
            controller: _scrollOtomatis,
            children: snapshot.data!.docs
                .map((dokumen) => CreateItemPesan(dokumen))
                .toList());
      },
    );
  }

  Widget CreateItemPesan(DocumentSnapshot dokumen) {
    Map<String, dynamic> myData = dokumen.data() as Map<String, dynamic>;

    var bubble = (myData['pengirimId'] == authChat.currentUser!.uid)
        ? pink
        : Color(0xff0D6105);
    var alignment = (myData['pengirimId'] == authChat.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (myData['pengirimId'] == authChat.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: bubble, borderRadius: BorderRadius.circular(35)),
              child: Text(
                myData['pesan'],
                style: teksputih.copyWith(fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _CustomInputPesan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            minLines: 1,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            controller: pesanKontroller,
            decoration: InputDecoration(
                filled: true,
                fillColor: putih,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: pink, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: pink, width: 2)),
                hintText: 'Ketik Sesuatu...',
                hintStyle: tekspink2.copyWith(fontSize: 12),
                contentPadding: EdgeInsets.all(15)),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: kirimPesan,
                  icon: Icon(
                    Icons.send,
                    size: 35,
                    color: pink,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
