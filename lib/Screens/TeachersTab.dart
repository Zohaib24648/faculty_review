import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:faculty_review/Providers/TeacherProvider.dart';
import 'package:faculty_review/Models/Teacher.dart';
import 'TeacherPage.dart';

class TeachersTab extends ConsumerStatefulWidget {
  const TeachersTab({super.key});

  @override
  _TeachersTabState createState() => _TeachersTabState();
}

class _TeachersTabState extends ConsumerState<TeachersTab> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final teachersAsyncValue = ref.watch(teachersProvider);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Search(
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
        ),
        Expanded(
          child: teachersAsyncValue.when(
            data: (teachers) {
              List<Teacher> filteredTeachers = teachers.where((teacher) {
                return teacher.name.toLowerCase().contains(search.toLowerCase());
              }).toList();

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
                        var teacher = filteredTeachers[index];
                        return TeacherCard(
                          name: teacher.name,
                          title: teacher.title,
                          base64Image: teacher.imageFile,
                          email: teacher.email,
                          id: teacher.id,
                        );
                      },
                      childCount: filteredTeachers.length,
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}

class TeacherCard extends StatelessWidget {
  final String base64Image;
  final String email;
  final String name;
  final String title;
  final String id;

  const TeacherCard({
    required this.base64Image,
    required this.email,
    required this.name,
    required this.title,
    required this.id,
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
            builder: (context) => TeacherPage(name: name),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white70,
        surfaceTintColor: Colors.white,
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.memory(bytes, fit: BoxFit.fill),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(email, style: const TextStyle(color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const Search({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
