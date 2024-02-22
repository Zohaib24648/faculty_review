import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Faculty Reviews',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFamily: GoogleFonts.spaceMono().fontFamily,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Image.network('https://hotsel-ms.vercel.app/assets/logos/ibalogo.png',)),

          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20,1,20,10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: TextFormField(decoration: const InputDecoration(hintText: "Email or ERP" ), style :TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: GoogleFonts.spaceMono().fontFamily,
              ),

                  textAlign: TextAlign.center),),

          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20,1,20,10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: TextFormField(decoration: const InputDecoration(hintText: "Enter your Password" ), style :TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: GoogleFonts.spaceMono().fontFamily,
              ),

                  textAlign: TextAlign.center),),

          ),
        ],
      ),
      backgroundColor: const Color(0xffffffff),
    );
  }
}
