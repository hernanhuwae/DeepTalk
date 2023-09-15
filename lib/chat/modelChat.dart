import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chatModel {
  final String pengirimId;
  final String pengirimEmail;
  final Timestamp waktu;
  final String pesan;
  final String penerimaId;

  chatModel(
      {required this.pengirimEmail,
      required this.pengirimId,
      required this.waktu,
      required this.pesan,
      required this.penerimaId});

  Map<String, dynamic> toMap() {
    return {
      'pengirimId': pengirimId,
      'pengirimEmail': pengirimEmail,
      'waktu': waktu,
      'pesan': pesan,
      'penerimaId': penerimaId,
    };
  }
}
