import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
class TeacherPage extends StatelessWidget {
  final String teachername;
  final courses;
  final base64Image;
  const TeacherPage({super.key,
    required this.base64Image,
    required this.courses,
    required this.teachername} );


  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64Image);
    return  Scaffold(
      appBar: AppBar(
        title:  Text(' $teachername'),
      ),
      body:  Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(bytes, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Courses: $courses'),
            ),
          ],


        )
      ),


    );
  }
}
