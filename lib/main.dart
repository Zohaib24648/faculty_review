import 'package:faculty_review/HomePage.dart';
import 'package:flutter/material.dart';
import './LoginPage.dart';
import './RegisterPage.dart';
import 'SearchCourses.dart';
import 'SearchTeachers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchTeachers(),
    );
  }
}
