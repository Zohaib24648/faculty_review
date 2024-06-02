import 'package:faculty_review/Screens/HomeFeedTab.dart';
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
        body:  TabBarView(
          children: [
            // HomeFeedTab(),
            const HomeFeed(),
            const TeachersTab(),
            Container(),
            // CoursesTab(),
          ],
        ),
        bottomSheet: Container(child:
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.forum_rounded, color: brownColor)),
              Tab(icon: Icon(Icons.person, color: brownColor)),
              Tab(icon: Icon(Icons.book, color: brownColor)),
            ],
          ),),
      ),
    );
  }
}
