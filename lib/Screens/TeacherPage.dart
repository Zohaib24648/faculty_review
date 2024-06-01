import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../Providers/CommentProvider.dart';
import '../constants.dart'; // Make sure this path is correct
import 'package:faculty_review/Providers/TeacherProvider.dart';
import 'package:faculty_review/Models/Teacher.dart';

class TeacherPage extends ConsumerStatefulWidget {
  final String name;

  const TeacherPage({
    required this.name,
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
      body: teachersAsyncValue.when(
        data: (teachers) {
          teacher = teachers.firstWhere((t) => t.name == widget.name);
          if (teacher == null) {
            return const Center(child: Text('Teacher not found'));
          }

          Uint8List bytes;
          try {
            bytes = base64Decode(teacher!.imageFile);
          } catch (e) {
            bytes = Uint8List(0); // Handle error or use a placeholder image
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  teacher!.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: brownColor),
                                ),
                                const SizedBox(height: 10),
                                _buildRatings(),
                                const SizedBox(height: 10),
                                // Text("Total Ratings: ${teacher!.totalRatings}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ButtonsTabBar(
                      controller: _tabController,
                      backgroundColor: Colors.blue,
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle: const TextStyle(
                          color: Colors.black),
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
                          ListView.builder(
                            itemCount: teacher!.coursesTaught.length,
                            itemBuilder: (BuildContext context, int index) {

                              return ListTile(
                                title: Text(teacher!.coursesTaught[index]),
                              );
                            },
                          ),
                          Column(
                            children: [
                              Text(teacher!.name.toString()),
                              Text(teacher!.email.toString()),
                              Text(teacher!.title.toString()),
                              Text(teacher!.department.toString()),
                              Text(teacher!.specialization.toString()),
                              Text(teacher!.onboardStatus.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildComments(),
                  ],
                ),
              ),
              _buildCommentInput(teacher!.id),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildRatings() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              'Grading: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              'Workload: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              'Learning: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     _buildRatingBar(teacher!.ratings[0].toDouble()),
        //     _buildRatingBar(teacher!.ratings[1].toDouble()),
        //     _buildRatingBar(teacher!.ratings[2].toDouble()),
        //     _buildRatingBar(teacher!.ratings[3].toDouble()),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildRatingBar(double rating) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) =>
      const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
    );
  }

  Widget _buildComments() {
    return Consumer(builder: (context, ref, child) {
      final commentsAsyncValue = ref.watch(commentsProvider(teacher!.id));
      return commentsAsyncValue.when(
        data: (comments) {
          if (comments.isEmpty) {
            return const Center(child: Text('No comments available.'));
          }
          return ListView.builder(
            shrinkWrap: true,
            // Important to prevent infinite height
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return ListTile(
                title: Text(comment.comment),
                subtitle: Text('By: ${comment.name}'),
              );
            },
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return const Text("Error");
        },
        loading: () {
          return const Text("Loading");
        },
      );
    });
  }

  Widget _buildCommentInput(String teacherId) {
    return Consumer(
      builder: (context, ref, child) {
        final postComment = ref.watch(postCommentProvider);

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Enter your comment here...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final commentText = _commentController.text;
                    if (commentText.isNotEmpty) {
                      // Ensure postComment is awaited
                      _commentController.clear();
                      await postComment(commentText, teacherId);
                      // Refresh comments after posting
                      ref.refresh(commentsProvider(teacherId));
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}