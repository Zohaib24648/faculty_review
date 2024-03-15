import 'package:faculty_review/TeacherPage.dart';
import 'package:flutter/material.dart';
import 'mongodbconnection.dart';
import 'dart:convert';
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
                                title: teacher['Title'],
                                base64Image: teacher['ImageFile'],
                                email: teacher['Email'],
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
  final String base64Image;
  final String email;
  final String name;
  final String title;

  const TeacherCard({
    required this.base64Image,
    required this.email,
    required this.name,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List bytes;
    try {
      bytes = base64Decode(base64Image);
    } catch (e) {
      // Handle error or use a placeholder image if decoding fails
      bytes = Uint8List(0); // Placeholder for an empty image
    }

    return InkWell(
      onTap: () async {
        // Fetch the detailed information based on the teacher's email
        var teacherDetail = await MongodbConnection().FindTeacher(email);
        // Debug print, consider removing for production
        print(teacherDetail);
        if (teacherDetail != null) {
          // Use the fetched teacherDetail to navigate to the TeacherPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherPage(teacherId: email), // Assuming email is used as a unique identifier for navigation
            ),
          );
        } else {
          // Handle the case where teacherDetail is null (e.g., show a message)
          const Center(
            child: Text('Error fetching teacher details or not found'),
          );
        }
      },
      child: Card(

        // clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (bytes.isNotEmpty) Image.memory(bytes, fit: BoxFit.cover,), // Show image only if bytes are not empty
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(title),
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
