import 'package:dechat/sharing/tema.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final String isiPesan;
  const BubbleChat({super.key, required this.isiPesan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration:
          BoxDecoration(color: pink, borderRadius: BorderRadius.circular(35)),
      child: Text(
        isiPesan,
        style: teksputih.copyWith(fontSize: 13),
      ),
    );
  }
}
