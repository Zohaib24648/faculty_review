import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../Models/Comment.dart';
import '../Providers/CommentProvider.dart';
import '../constants.dart'; // Make sure this path is correct
import 'package:faculty_review/Providers/TeacherProvider.dart';
import 'package:faculty_review/Models/Teacher.dart';
import 'package:timeago/timeago.dart' as timeago;

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
        title: const Text('Teacher Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: brownColor,
        foregroundColor: Colors.white,
      ),
      body: teachersAsyncValue.when(
        data: (teachers) {
          teacher = teachers.firstWhere((t) => t.name == widget.name);
          if (teacher == null) {
            return const Center(
                child:
                    Text('Teacher not found', style: TextStyle(fontSize: 18)));
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            // padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          teacher!.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: brownColor),
                                        ),
                                        _buildRatings(),
                                        // Text("Total Ratings: ${teacher!.totalRatings}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ButtonsTabBar(
                      controller: _tabController,
                      backgroundColor: brownColor,
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow("Name:", teacher!.name),
                                _buildInfoRow("Email:", teacher!.email),
                                _buildInfoRow("Title:", teacher!.title),
                                _buildInfoRow(
                                    "Department:", teacher!.department),
                                _buildInfoRow(
                                    "Specialization:", teacher!.specialization),
                                _buildInfoRow(
                                    "Onboard Status:", teacher!.onboardStatus),
                              ],
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: teacher!.coursesTaught.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(teacher!.coursesTaught[index]),
                                  trailing: Icon(Icons.arrow_forward,
                                      color: Colors.deepPurple),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                teacher!.overview,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommentsWidget(teacherId: teacher!.id)
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
            _buildRatingBar(teacher!.ratings[0].toDouble()),
            _buildRatingBar(teacher!.ratings[1].toDouble()),
            _buildRatingBar(teacher!.ratings[2].toDouble()),
            _buildRatingBar(teacher!.ratings[3].toDouble()),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBar(double rating) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
    );
  }

  //
  // Widget _buildComments() {
  //   return Consumer(builder: (context, ref, child) {
  //     final commentsAsyncValue = ref.watch(commentsProvider(teacher!.id));
  //     return commentsAsyncValue.when(
  //       data: (comments) {
  //         if (comments.isEmpty) {
  //           return const Center(child: Text('No comments available.'));
  //         }
  //         return ListView.builder(
  //           shrinkWrap: true,
  //           // Important to prevent infinite height
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: comments.length,
  //           itemBuilder: (context, index) {
  //             final comment = comments[index];
  //             return ListTile(
  //               title: Text(comment.comment),
  //               subtitle: Text('By: ${comment.name}'),
  //             );
  //           },
  //         );
  //       },
  //       error: (Object error, StackTrace stackTrace) {
  //         return const Text("Error");
  //       },
  //       loading: () {
  //         return const Text("Loading");
  //       },
  //     );
  //   });
  // }
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: brownColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
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
                      _commentController.clear();
                      bool success = await postComment(teacherId, commentText);
                      // Refresh comments after posting
                      ref.refresh(commentsProvider(teacherId));

                      // Show snackbar based on the success of the operation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(true
                              ? 'Comment posted successfully'
                              : 'Failed to post comment'),
                        ),
                      );
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

class CommentsWidget extends StatelessWidget {
  final String teacherId;

  const CommentsWidget({required this.teacherId, super.key});

  Widget _buildComments() {
    return Consumer(builder: (context, ref, child) {
      final commentsAsyncValue = ref.watch(commentsProvider(teacherId));
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
              return _buildCommentTile(comment);
            },
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text("Sorry No Comments Available"));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      );
    });
  }

  Widget _buildCommentTile(Comment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            comment.comment,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.anonymous ? 'Anonymous' : 'By: ${comment.name}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      // Handle upvote
                    },
                  ),
                  Text('${comment.upVotes - comment.downVotes}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      // Handle downvote
                    },
                  ),
                  const Spacer(),
                  Text(
                    timeago.format(comment.createdAt),
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildComments();
  }
}
