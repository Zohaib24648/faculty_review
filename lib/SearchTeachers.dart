import 'package:faculty_review/TeacherPage.dart';
import 'package:flutter/material.dart';
import 'mongodbconnection.dart';
import 'dart:convert';
import 'TeacherPage.dart';
import 'constants.dart';
import 'dart:typed_data';


class SearchTeachers extends StatefulWidget {
  const SearchTeachers({super.key});

  @override
  State<SearchTeachers> createState() => _SearchTeachersState();
}

class _SearchTeachersState extends State<SearchTeachers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
          // leading:  IconButton(icon:Icon(Icons.menu), color: brownColor, onPressed: () { MenuItemButton },),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person, color: brownColor)),
              Tab(icon: Icon(Icons.book, color: brownColor)),
              Tab(icon: Icon(Icons.school, color:brownColor)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<dynamic>>(
              future: MongodbConnection().Teachers(), // Call allTeacher() method and await the result
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Show an error message if data retrieval fails
                } else {
                  // Use CustomScrollView with SliverGrid
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.all(10),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            crossAxisSpacing: 10, // Horizontal space between items
                            mainAxisSpacing: 10, // Vertical space between items
                            childAspectRatio: 2 / 3, // Aspect ratio of the cards
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              var teacher = snapshot.data![index];
                              return TeacherCard(
                                name: teacher['Name'],
                                courses: teacher['Courses Taught'],
                                base64Image: teacher['ImageFile'],
                              );
                            },
                            childCount: snapshot.data?.length ?? 0, // Number of items in the grid
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            FutureBuilder <List<dynamic>>(future:MongodbConnection().allCourses() , builder: (context, snapshot) {
              if ((snapshot.connectionState == ConnectionState.waiting)) {
                 return  const Center(
                   child: CircularProgressIndicator(
                     strokeWidth: 2, // Adjust the stroke width as needed
                   ),
                 );
              }    else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: (snapshot.data ?? []).map((course) {
                      return CourseCard(
                        name: course['name'],
                        major: course['major'], rating: course['rating'],
                      );
                    }).toList(),
                  ),
                );
              }
            },
            ),
            FutureBuilder <List<dynamic>>(future:MongodbConnection().allMajors() , builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2, // Adjust the stroke width as needed
                  ),
                );

              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: (snapshot.data ?? []).map((course) {
                      return MajorCard(
                        major: course['major'],
                      );
                    }).toList(),
                  ),
                );
              }
            },
            ),
          ],
        ),
        ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final String name;
  final dynamic courses;
  final String base64Image; // Add this line

  const TeacherCard({
    required this.name,
    required this.courses,
    required this.base64Image, // Add this line
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64Image); // Decode the Base64 string

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherPage(teachername: name, courses: courses, base64Image: base64Image),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Image.memory(bytes, fit: BoxFit.cover), // Display the image
            Text(name),
            // You can add more widgets here to display other details
          ],
        ),
      ),
    );
  }
}


class CourseCard extends StatelessWidget {
  final String name;
  final dynamic major;
  final dynamic rating;

  const CourseCard({
    required this.name,
    required this.major,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Courses: $major, Rating: $rating'),
        leading: const Icon(Icons.person, color: Color(0xff700f1a), size:40,),
      ),
    );
  }
}



class MajorCard extends StatelessWidget {
  final dynamic major;
  const MajorCard({
    required this.major,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(major),
        leading: const Icon(Icons.person, color: Color(0xff700f1a), size:40,),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SearchTeachers(),
  ));
}
