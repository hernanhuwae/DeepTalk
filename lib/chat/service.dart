import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dechat/chat/modelChat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeepTalkChatService extends ChangeNotifier {
  Future<void> kirimPesan(String penerimaId, String pesan) async {
    final String userIdNow = FirebaseAuth.instance.currentUser!.uid;
    final String userEmailNow =
        FirebaseAuth.instance.currentUser!.email.toString();
    final Timestamp waktuNow = Timestamp.now();

    chatModel newPesan = chatModel(
        pengirimEmail: userEmailNow,
        pengirimId: userIdNow,
        waktu: waktuNow,
        pesan: pesan,
        penerimaId: penerimaId);

    //TODO: Chat room Id
    List<String> id = [userIdNow, penerimaId];
    id.sort();
    String deeptalkRoomId = id.join("_");

    //TODO: Tambah pesan baru di firebase
    await FirebaseFirestore.instance
        .collection('ruangchat')
        .doc(deeptalkRoomId)
        .collection('allpesan')
        .add(newPesan.toMap());
  }

  //TODO: Dapat semua isi data Pesan
  Stream<QuerySnapshot> getPesan(String userId, String otherUserId) {
    List<String> id = [userId, otherUserId];
    id.sort();
    String deeptalkRoomId = id.join("_");

    return FirebaseFirestore.instance
        .collection('ruangchat')
        .doc(deeptalkRoomId)
        .collection('allpesan')
        .orderBy('waktu', descending: false)
        .snapshots();
  }
}
