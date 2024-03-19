import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'mongodbconnection.dart';
import 'constants.dart';

class TeacherPage extends StatelessWidget {
  final String teacherId;

  const TeacherPage({
    required this.teacherId,
    Key? key,
  }) : super(key: key);

  Future<Map<String, dynamic>?> fetchTeacherDetails() async {
    var teacherDetail = await MongodbConnection().FindTeacher(teacherId);
    return teacherDetail;
  }

  @override
  Widget build(BuildContext context) {
    String _review = '';
    int?
        _parentId; // Set this to the Parent_id of the parent comment if it's a reply
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>?>(
            future: fetchTeacherDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                    child: Text('Error fetching teacher details or not found'));
              } else {
                var teacherDetails = snapshot.data!;
                Uint8List bytes;
                try {
                  bytes = base64Decode(teacherDetails['ImageFile']);
                } catch (e) {
                  // Fallback for images that fail to decode
                  bytes = Uint8List(0);
                }

                // Now fetching and displaying comments
                return Column(
                  children: [
                    Column(
                      //                  crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (bytes.isNotEmpty)
                              Expanded(
                                flex: 3,
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 10, 10),
                                    child:
                                        Image.memory(bytes, fit: BoxFit.cover)),
                              ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${teacherDetails['Name']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: brownColor),
                                  ),
                                  Text("${teacherDetails['Title']}"),
                                  Text("Email ${teacherDetails['Email']}"),
                                  Text(
                                      "Department: ${teacherDetails['Department']}"),
                                  Text(
                                      "Specialization: ${teacherDetails['Specialization']}"),
                                  Text(
                                      "Onboard Status: ${teacherDetails['Onboard Status']}"),
                                ],
                              ),
                            )
                          ],
                        ),
                        // Text("Overview: ${teacherDetails['Overview']}"),
                        // Text("Courses Taught: ${teacherDetails['Courses Taught']}"),

                        FutureBuilder<List<dynamic>>(
                          future: MongodbConnection().allParentReviews(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var comments = snapshot.data ?? [];
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return CommentWidget(
                                      comment: comments[index]);
                                },
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CommentForm(),
        ),
      ]),
    );
  }
}

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  String _review = '';
  int? _parentId; // null for new comments, set for replies

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Make room for the keyboard
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
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Post a Review",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _review = value ?? '',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a review';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Your logic to post the review goes here
                      // Remember to handle _parentId correctly for parent comments and replies
                      // Reset the form and _parentId as needed after posting
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

class CommentWidget extends StatefulWidget {
  final dynamic comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<dynamic>? _replies; // Now this can be null or have replies

  void _fetchReplies() async {
    if (_replies == null) {
      // Fetch replies only if they haven't been fetched
      var replies =
          await MongodbConnection().fetchReplies(widget.comment['comment_id']);
      setState(() {
        _replies = replies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Row(
              children: [
                const Icon(Icons.person,
                    color: Colors.brown, size: 40),
                Text(widget.comment['comment_maker'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(widget.comment['Comment']),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.more_vert_outlined,
                        color: Colors.brown),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          10, 0, 0, 0),
                      child: Icon(Icons.reply,
                          color: Colors.brown),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          20, 0, 0, 0),
                      child: Icon(Icons.thumb_up,
                          color: Colors.brown),
                    ),
                    Text(' ${widget.comment['upvotes']}'),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                          10.0, 0, 0, 0),
                      child: Icon(Icons.thumb_down,
                          color: Colors.brown),
                    ),
                    Text(' ${widget.comment['downvotes']}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_replies ==
            null) // Show the button only if replies haven't been fetched
          TextButton(
            onPressed: _fetchReplies,
            child: const Text("View Replies"),
          ),
        // Display replies if there are any
        if (_replies != null)
          ..._replies!.map((reply) => Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(reply['Comment']),
                  subtitle: Text(
                      "Rating: ${reply['Rating']} by ${reply['comment_maker']}"),
                ),
              )),
      ],
    );
  }
}
