import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/CommentProvider.dart';
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
  TeacherPageState createState() => TeacherPageState();
}

class TeacherPageState extends ConsumerState<TeacherPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Teacher? teacher;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teachersAsyncValue = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                teachersAsyncValue.when(
                  data: (teachers) {
                    for (final t in teachers) {
                      if (t.email == widget.email) {
                        teacher = t;
                        break;
                      }
                    }

                    if (teacher != null) {
                      Uint8List bytes = Uint8List(0);
                      try {
                        bytes = base64Decode(teacher!.imageFile);
                      } catch (e) {
                        // Handle error or use a placeholder image
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Image.memory(bytes, fit: BoxFit.cover),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(teacher!.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: brownColor)),
                                      ),
                                      Row(
                                        children: [
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Attendance: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Grading: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Workload: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'Learning: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              RatingBarIndicator(
                                                rating: teacher!.ratings[0]
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              RatingBarIndicator(
                                                rating: teacher!.ratings[1]
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              RatingBarIndicator(
                                                rating: teacher!.ratings[2]
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              RatingBarIndicator(
                                                rating: teacher!.ratings[3]
                                                    .toDouble(),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
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
                                      Text(
                                          "Total Ratings: ${teacher!.totalRatings}"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Other widgets...
                        ],
                      );
                    } else {
                      return const Center(child: Text('Teacher not found'));
                    }
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                ),
                ButtonsTabBar(
                  controller: _tabController,
                  backgroundColor: Colors.blue,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
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
                      Center(child: Text(teacher!.overview)),
                      Center(
                        child: ListView.builder(
                          itemCount: teacher!.coursesTaught.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(teacher!.coursesTaught[index]),
                            );
                          },
                        ),
                      ),
                      Center(child: Text(teacher!.toString())),
                    ],
                  ),
                ),
                Consumer(builder: (context, ref, child) {
                  final commentsAsyncValue =
                      ref.watch(commentProvider(teacher!.id));
                  return commentsAsyncValue.when(data: (comments) {
                    return ListView.builder(
                      shrinkWrap: true,
                      // Important to prevent infinite height
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        print(comment.toString());
                        return ListTile(
                          title: Text(comment.comment),
                          subtitle: Text('By: ${comment.name}'),
                        );
                      },
                    );
                  }, error: (Object error, StackTrace stackTrace) {
                    return const Text("Error");
                  }, loading: () {
                    return const Text("Loading");
                  });
                })
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter
            ,child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Enter your comment here...",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Handle sending the comment...
                      print("I Am Commenting ${_commentController.text} on the teacher ${teacher!.name} and the id of the teacher is ${teacher!.id}");
                      _commentController.clear();

                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
