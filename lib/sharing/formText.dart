import 'package:dechat/sharing/tema.dart';
import 'package:flutter/material.dart';

class deeptalkForm extends StatelessWidget {
  final String teksform;
  final TextEditingController kontroller;
  final bool hide;
  final Icon icons;
  const deeptalkForm(
      {required this.teksform,
      required this.kontroller,
      required this.hide,
      required this.icons,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 75, right: 75),
      padding: EdgeInsets.only(
        right: 5,
        top: 5,
      ),
      child: TextField(
        controller: kontroller,
        style: teksputih,
        obscureText: hide,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 10),
              child: icons,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: putih),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: putih, width: 2)),
            hintText: teksform,
            hintStyle: tekspink.copyWith(fontSize: 15, fontWeight: regular)),
      ),
    );
  }
}
