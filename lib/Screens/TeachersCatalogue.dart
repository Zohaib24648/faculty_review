// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:faculty_review/Models/Teacher.dart';
// import 'package:faculty_review/Screens/TeacherPage.dart';
// import 'package:faculty_review/mongodbconnection.dart';
// import 'dart:convert';
// import '../constants.dart';
// import 'dart:typed_data';
// import 'package:faculty_review/Providers/TeacherProvider.dart';
//
// final coursesProvider = FutureProvider<List<dynamic>>((ref) async {
//   return MongodbConnection().allCourses();
// });
//
// final majorsProvider = FutureProvider<List<dynamic>>((ref) async {
//   return MongodbConnection().allMajors();
// });
//
// // Convert TeachersCatalogue to a ConsumerWidget
// class TeachersCatalogue extends ConsumerWidget {
//   const TeachersCatalogue({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Use providers to fetch data
//     final teachers = ref.watch(teacherProvider);
//     final courses = ref.watch(coursesProvider);
//     final majors = ref.watch(majorsProvider);
//
//     return DefaultTabController(
//       initialIndex: 1,
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: const Center(
//             child: Text(
//               'Faculty Reviews',
//               style: TextStyle(
//                 color: brownColor,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//                 fontFamily: 'Space Mono',
//               ),
//             ),
//           ),
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.person, color: brownColor)),
//               Tab(icon: Icon(Icons.book, color: brownColor)),
//               Tab(icon: Icon(Icons.school, color: brownColor)),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // Use the teachers data to build the UI
//             teachers.when(
//               data: (data) {
//                 // Build the UI with the data
//                 return CustomScrollView(
//                   slivers: <Widget>[
//                     SliverPadding(
//                       padding: const EdgeInsets.all(10),
//                       sliver: SliverGrid(
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                           childAspectRatio: 2 / 3,
//                         ),
//                         delegate: SliverChildBuilderDelegate(
//                               (BuildContext context, int index) {
//                             var teacher = data[index];
//                             return TeacherCard(
//                               name: teacher.name,
//                               title: teacher.title,
//                               base64Image: teacher.imageFile,
//                               email: teacher.email,
//                             );
//                           },
//                           childCount: data.length,
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, _) => Text('Error: $error'),
//             ),
//
//             // Similarly, use the courses data to build the UI
//             courses.when(
//               data: (data) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: data.map((course) {
//                       return CourseCard(
//                         name: course['name'],
//                         major: course['major'],
//                         rating: course['rating'],
//                       );
//                     }).toList(),
//                   ),
//                 );
//               },
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, _) => Text('Error: $error'),
//             ),
//
//             // Use the majors data to build the UI
//             majors.when(
//               data: (data) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: data.map((major) {
//                       return MajorCard(
//                         major: major['major'],
//                       );
//                     }).toList(),
//                   ),
//                 );
//               },
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (error, _) => Text('Error: $error'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class TeacherCard extends StatelessWidget {
//   final String base64Image;
//   final String email;
//   final String name;
//   final String title;
//
//   const TeacherCard({
//     required this.base64Image,
//     required this.email,
//     required this.name,
//     required this.title,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Uint8List bytes;
//     try {
//       bytes = base64Decode(base64Image);
//     } catch (e) {
//       // Handle error or use a placeholder image if decoding fails
//       bytes = Uint8List(0); // Placeholder for an empty image
//     }
//
//     return InkWell(
//       onTap: () async {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TeacherPage(email: email) // Assuming email is used as a unique identifier for navigation
//       ));
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 4,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (bytes.isNotEmpty) Image.memory(bytes, fit: BoxFit.fill,), // Show image only if bytes are not empty
//             Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//             Text(title),
//             Text(email, style: const TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CourseCard extends StatelessWidget {
//   final String name;
//   final dynamic major;
//   final dynamic rating;
//
//   const CourseCard({
//     required this.name,
//     required this.major,
//     required this.rating,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(name),
//         subtitle: Text('Courses: $major, Rating: $rating'),
//         leading: const Icon(Icons.person, color: Color(0xff700f1a), size:40,),
//       ),
//     );
//   }
// }
//
//
//
// class MajorCard extends StatelessWidget {
//   final dynamic major;
//   const MajorCard({
//     required this.major,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(major),
//         leading: const Icon(Icons.person, color: Color(0xff700f1a), size:40,),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(const MaterialApp(
//     home: TeachersCatalogue(),
//   ));
// }
