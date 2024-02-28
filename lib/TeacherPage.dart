import 'package:flutter/material.dart';
class TeacherPage extends StatelessWidget {
  final String teachername;
  const TeacherPage({super.key, required this.teachername} );


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(' $teachername  name'),
      ),
      body: const Center(
        child: Text('Teacher Page'),
      ),


    );
  }
}
