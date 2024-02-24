import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SearchTeachers.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Faculty Reviews',
            style: TextStyle(
              color: const Color(0xff700f1a),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFamily: GoogleFonts.spaceMono().fontFamily,
            ),
          ),
        ),
        actions:<Widget> [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchTeachers()));
          }, child: Text('Teachers')),
          TextButton(onPressed: (){}, child: Text('Courses')),
          // TextButton(onPressed: onPressed, child: Text('Major')),
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}


