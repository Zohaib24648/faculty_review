import 'package:flutter/material.dart';
class SearchTeachers extends StatefulWidget {
  const SearchTeachers({super.key});

  @override
  State<SearchTeachers> createState() => _SearchTeachersState();
}

class _SearchTeachersState extends State<SearchTeachers> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Faculty Reviews',
              style: TextStyle(
                color: Color(0xff700f1a),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: 'Space Mono',
              ),
            ),

          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person,color: Color(0xff700f1a),), text: 'Teachers',),
              Tab(icon: Icon(Icons.book,color: Color(0xff700f1a),), text: 'Courses',),
              Tab(icon: Icon(Icons.school,color: Color(0xff700f1a)), text: 'Major',),
            ],
          )

        ),
        body:  TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // for  (var teacher in teacherslist)
                  // {}
                  Card(
                    child: ListTile(
                      title: Text('Teacher 1'),
                      trailing: Text('Courses: 5'),
                      subtitle: Text('Rating: 4.5'),
                      leading: CircleAvatar(
                        //   backgroundImage: AssetImage('assets/images/teacher1.jpg'),
                      ),
                    ),
                  ),
                  ]),
            ),
            Center(
              child: Text('Courses'),
            ),
            Center(
              child: Text('Major'),
            ),
          ],
        ),
      ),
    );
}}

class TeacherCard {
  TeacherCard({required this.name, required this.courses, required this.rating});

  final String name;
  final int courses;
  final double rating;
}

final List<dynamic> teacherslist = [
  {"name": "Teacher 1", "courses": 5, "rating": 4.5},
  {"name": "Teacher 2", "courses": 4, "rating": 4.8},
  {"name": "Teacher 3", "courses": 3, "rating": 4.2},
  {"name": "Teacher 4", "courses": 5, "rating": 4.9},
  {"name": "Teacher 5", "courses": 2, "rating": 4.0},
  {"name": "Teacher 6", "courses": 3, "rating": 4.3},
  {"name": "Teacher 7", "courses": 4, "rating": 4.6},
  {"name": "Teacher 8", "courses": 5, "rating": 4.7},
  {"name": "Teacher 9", "courses": 2, "rating": 4.1},
  {"name": "Teacher 10", "courses": 4, "rating": 4.5},
  {"name": "Teacher 11", "courses": 5, "rating": 4.8},
  {"name": "Teacher 12", "courses": 3, "rating": 4.0},
  {"name": "Teacher 13", "courses": 5, "rating": 4.9},
  {"name": "Teacher 14", "courses": 2, "rating": 4.2},
  {"name": "Teacher 15", "courses": 3, "rating": 4.4},
  {"name": "Teacher 16", "courses": 4, "rating": 4.6},
  {"name": "Teacher 17", "courses": 5, "rating": 4.7},
  {"name": "Teacher 18", "courses": 2, "rating": 3.9},
  {"name": "Teacher 19", "courses": 4, "rating": 4.5},
  {"name": "Teacher 20", "courses": 3, "rating": 4.3},
];
