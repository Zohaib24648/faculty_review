import 'package:flutter/material.dart';
import '../constants.dart';
import 'TeachersTab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Faculty Reviews',
              style: TextStyle(
                color: brownColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: 'Space Mono',
              ),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.school, color: brownColor)),
              Tab(icon: Icon(Icons.person, color: brownColor)),
              Tab(icon: Icon(Icons.book, color: brownColor)),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            // HomeFeedTab(),
            const TeachersTab(),
            Container(),
            Container(),
            // CoursesTab(),
          ],
        ),
      ),
    );
  }
}
