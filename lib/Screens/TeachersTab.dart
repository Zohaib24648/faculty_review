import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:faculty_review/Providers/TeacherProvider.dart';

import 'TeacherPage.dart';
class TeachersTab extends ConsumerWidget {
  const TeachersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsyncValue = ref.watch(teachersProvider);

    return teachersAsyncValue.when(
      data: (teachers) {
        return CustomScrollView(
          slivers: <Widget>[
             SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 5,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    var teacher = teachers[index];
                    return TeacherCard(
                      name: teacher.name,
                      title: teacher.title,
                      base64Image: teacher.imageFile,
                      email: teacher.email,
                    );
                  },
                  childCount: teachers.length,
                ),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error: $error'),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List bytes;
    try {
      bytes = base64Decode(base64Image);
    } catch (e) {
      bytes = Uint8List(0); // Placeholder for an empty image
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherPage(email: email),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white70,
        surfaceTintColor: Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        elevation: 4,
        child: Column(
          children: <Widget>[

            Expanded(flex: 3,
                child: Container(child: Image.memory(bytes, fit: BoxFit.fill))),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children:[
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    Text(title, maxLines: 1),
                    Text(email, style: const TextStyle(color: Colors.grey),maxLines: 1,),
                  ]
                )
              ),
            )

          ],
        ),
      ),
    );
  }
}
