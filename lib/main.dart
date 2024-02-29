import 'package:faculty_review/SearchTeachers.dart';
import 'package:flutter/material.dart';
import './RegisterPage.dart';
import 'mongodbconnection.dart';



void main() async {

  runApp(const MyApp());

  MongodbConnection.getDb();

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
      home:  const RegisterPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
