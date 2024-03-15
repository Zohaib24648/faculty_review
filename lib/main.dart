import 'package:flutter/material.dart';
import './RegisterPage.dart';
import 'mongodbconnection.dart';



void main() async {
  MongodbConnection.getDb();
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
      home:  const RegisterPage(),
    );
  }
}
