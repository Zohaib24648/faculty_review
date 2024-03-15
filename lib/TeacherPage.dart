import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:comment_tree/comment_tree.dart';

import 'mongodbconnection.dart';

class TeacherPage extends StatefulWidget {
  final String teacherId;

  const TeacherPage({
    required this.teacherId,
    super.key,
  });

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  Future<Map<String, dynamic>?> fetchTeacherDetails() async {
    // Replace with your actual database fetch method
    var teacherDetail = await MongodbConnection().FindTeacher(widget.teacherId);
    return teacherDetail; // Ensure this is your actual fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'), // Updated to a more generic text
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchTeacherDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            // Combined check for errors or null data
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (bytes.isNotEmpty)
                          Expanded(
                            child: Container(
                                child: Image.memory(bytes, fit: BoxFit.cover),
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 10)),
                            flex: 3,
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
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: brownColor, width: 2),
//    borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(0, 0, 0, 0),
                              ))),
                        ),
                      ),
                    ),
                    const Card(
                        // isexpanded for keeping track of if the subtitle is expanded or not
                        child: ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.person, color: brownColor, size: 40),
                                Text('John Doe',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra ex a nisl porta, quis rhoncus neque vehicula. Sed gravida enim nibh, in sodales magna accumsan et. Donec pellentesque nibh eu aliquam accumsan. Nullam eleifend vitae odio id posuere. In ex velit, scelerisque vel diam eget, sodales pretium eros. Mauris pulvinar sem et faucibus placerat. Mauris iaculis nisi vel nulla euismod, in tempus massa iaculis. Vestibulum "),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.more_vert_outlined,
                                        color: brownColor),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(Icons.reply,
                                          color: brownColor),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Icon(Icons.thumb_up,
                                          color: brownColor),
                                    ),
                                    Text(' 10'),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                      child: Icon(Icons.thumb_down,
                                          color: brownColor),
                                    ),
                                    Text(' 2'),
                                  ],
                                ),
                              ],
                            )
                        )

                    ),
                    Row(
                      children: [
                        TextButton(onPressed: () {
                          print("Replied");

                        }, child:
                        Text("Reply")),

                        TextButton(onPressed: () {
                          print("Upvoted");
                        }, child: Text("Upvote")),

                        TextButton(onPressed: () {
                          print("Downvoted");
                        }, child: Text("Downvote"))

                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(40,0,0,0),
                      child: Card(
                        // isexpanded for keeping track of if the subtitle is expanded or not
                          child: ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.person, color: brownColor, size: 40),
                                  Text('John Doe',
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra ex a nisl porta, quis rhoncus neque vehicula. Sed gravida enim nibh, in sodales magna accumsan et. Donec pellentesque nibh eu aliquam accumsan. Nullam eleifend vitae odio id posuere. In ex velit, scelerisque vel diam eget, sodales pretium eros. Mauris pulvinar sem et faucibus placerat. Mauris iaculis nisi vel nulla euismod, in tempus massa iaculis. Vestibulum "),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.more_vert_outlined,
                                          color: brownColor),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Icon(Icons.reply,
                                            color: brownColor),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Icon(Icons.thumb_up,
                                            color: brownColor),
                                      ),
                                      Text(' 10'),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                        child: Icon(Icons.thumb_down,
                                            color: brownColor),
                                      ),
                                      Text(' 2'),
                                    ],
                                  ),

                                ],

                              )

                          )
                      ),


                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,0,0,0),
                      child: Row(
                        children: [
                          TextButton(onPressed: () {
                            print("Replied");

                          }, child:
                          Text("Reply")),

                          TextButton(onPressed: () {
                            print("Upvoted");
                          }, child: Text("Upvote")),

                          TextButton(onPressed: () {
                            print("Downvoted");
                          }, child: Text("Downvote"))

                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(80,0,0,0),
                      child: Card(
                        // isexpanded for keeping track of if the subtitle is expanded or not
                          child: ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.person, color: brownColor, size: 40),
                                  Text('John Doe',
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra ex a nisl porta, quis rhoncus neque vehicula. Sed gravida enim nibh, in sodales magna accumsan et. Donec pellentesque nibh eu aliquam accumsan. Nullam eleifend vitae odio id posuere. In ex velit, scelerisque vel diam eget, sodales pretium eros. Mauris pulvinar sem et faucibus placerat. Mauris iaculis nisi vel nulla euismod, in tempus massa iaculis. Vestibulum "),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.more_vert_outlined,
                                          color: brownColor),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Icon(Icons.reply,
                                            color: brownColor),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Icon(Icons.thumb_up,
                                            color: brownColor),
                                      ),
                                      Text(' 10'),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                        child: Icon(Icons.thumb_down,
                                            color: brownColor),
                                      ),
                                      Text(' 2'),
                                    ],
                                  ),

                                ],

                              )

                          )
                      ),


                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80,0,0,0),
                      child: Row(
                        children: [
                          TextButton(onPressed: () {
                            print("Replied");

                          }, child:
                          Text("Reply")),

                          TextButton(onPressed: () {
                            print("Upvoted");
                          }, child: Text("Upvote")),

                          TextButton(onPressed: () {
                            print("Downvoted");
                          }, child: Text("Downvote"))

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
