import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Screens/RegisterPage.dart';
import 'mongodbconnection.dart';



void main() async {
  MongodbConnection.initializeConnection();
runApp(const ProviderScope(child: MyApp()));


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcademiQ',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,

        ),
        primarySwatch: Colors.brown,
      ),
      home:  const RegisterPage(),
    );
  }
}
