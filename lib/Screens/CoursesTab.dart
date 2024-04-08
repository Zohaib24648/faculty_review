// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:faculty_review/Providers/CourseProvider.dart';
//
// class CoursesTab extends ConsumerWidget {
//   const CoursesTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final coursesAsyncValue = ref.watch(coursesProvider);
//
//     return coursesAsyncValue.when(
//       data: (courses) {
//         return SingleChildScrollView(
//           child: Column(
//             children: courses.map((course) {
//               return CourseCard(
//                 name: course['name'],
//                 major: course['major'],
//                 rating: course['rating'],
//               );
//             }).toList(),
//           ),
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, _) => Text('Error: $error'),
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
//         subtitle: Text('Major: $major, Rating: $rating'),
//         leading: const Icon(Icons.book, color: Color(0xff700f1a), size: 40),
//       ),
//     );
//   }
// }
