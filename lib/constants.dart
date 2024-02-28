import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color brownColor = Color(0xff700f1a);


class Constants {


  static final AppBar constantAppBar = AppBar(
    backgroundColor: Colors.white,
    title: const Center(
      child: Text(
        'Faculty Reviews',
        style: TextStyle(
          color: brownColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  );

  Constants();
}
