import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding buttonStart(Size size, VoidCallback changeButton,
    {required String text, required bool isChanged,}) {
  return Padding(
    padding: EdgeInsets.only(top: size.height * 0.02),
    child: SizedBox(
        width: isChanged ?  size.width * 0.2 : size.width * 0.8 ,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    isChanged ? Colors.white54 : Colors.blue)),
            onPressed: changeButton,
            child: isChanged
                ? const CircularProgressIndicator()
                : Text(
                    text,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ))),
  );
}
