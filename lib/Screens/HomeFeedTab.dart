// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'majors_provider.dart'; // Import your provider for majors
//
// class HomeFeedTab extends ConsumerWidget {
//   const HomeFeedTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final majorsAsyncValue = ref.watch(majorsProvider);
//
//     return majorsAsyncValue.when(
//       data: (majors) {
//         return SingleChildScrollView(
//           child: Column(
//             children: majors.map((major) {
//               return MajorCard(
//                 major: major['major'],
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
// class MajorCard extends StatelessWidget {
//   final dynamic major;
//
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
//         leading: const Icon(Icons.school, color: Color(0xff700f1a), size:40,),
//       ),
//     );
//   }
// }
