import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart'; // Make sure this path is correct
import 'package:faculty_review/Providers/TeacherProvider.dart';
import 'package:faculty_review/Models/Teacher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TeacherPage extends ConsumerStatefulWidget {
  final String email;

  const TeacherPage({
    required this.email,
    super.key,
  });

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends ConsumerState<TeacherPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teachersAsyncValue = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            teachersAsyncValue.when(
              data: (teachers) {
                Teacher? teacher;
                for (final t in teachers) {
                  if (t.email == widget.email) {
                    teacher = t;
                    break;
                  }
                }

                if (teacher != null) {
                  Uint8List bytes = Uint8List(0);
                  try {
                    bytes = base64Decode(teacher.imageFile);
                  } catch (e) {
                    // Handle error or use a placeholder image
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(child: Image.memory(bytes, fit: BoxFit.cover)),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(teacher.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: brownColor)),
                                  ),
                                  Row(
                                    children: [
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Attendance: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                          Text(
                                            'Grading: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                          Text(
                                            'Workload: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                          Text(
                                            'Learning: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          RatingBarIndicator(
                                            rating: teacher.ratings[0].toDouble(),
                                            itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                          ),
                                          RatingBarIndicator(
                                            rating: teacher.ratings[1].toDouble(),
                                            itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                          ),
                                          RatingBarIndicator(
                                            rating: teacher.ratings[2].toDouble(),
                                            itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                          ),
                                          RatingBarIndicator(
                                            rating: teacher.ratings[3].toDouble(),
                                            itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text("Total Ratings: ${teacher.totalRatings}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(teacher.title),
                          Text("Email: ${teacher.email}"),
                          Text("Department: ${teacher.department}"),
                          Text("Specialization: ${teacher.specialization}"),
                          Text("Onboard Status: ${teacher.onboardStatus}"),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('Teacher not found'));
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
            ButtonsTabBar(
              controller: _tabController,
              backgroundColor: Colors.blue,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: TextStyle(color: Colors.black),
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "Overview"),
                Tab(text: "Courses Taught"),
                Tab(text: "Details"),
              ],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text('Overview Content')),
                  Center(child: Text('Courses Taught Content')),
                  Center(child: Text('Details Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  String _review = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Post a Review",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _review = value ?? '',
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter a review'
                        : null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Add logic to post the review
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
