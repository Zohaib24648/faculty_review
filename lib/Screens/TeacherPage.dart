import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import 'package:faculty_review/Providers/TeacherProvider.dart';
import 'package:faculty_review/Models/Teacher.dart';

class TeacherPage extends ConsumerWidget {
  final String email;

  const TeacherPage({
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsyncValue = ref.watch(teachersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: teachersAsyncValue.when(
              data: (teachers) {Teacher? teacher;
              for (final t in teachers) {
                print("Looping to find teacher");
                if (t.email == email) {
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
                          if (bytes.isNotEmpty)
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: Image.memory(bytes, fit: BoxFit.cover),
                              ),
                            ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(teacher.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: brownColor)),
                                Text(teacher.title),
                                Text("Email: ${teacher.email}"),
                                Text("Department: ${teacher.department}"),
                                Text("Specialization: ${teacher.specialization}"),
                                Text("Onboard Status: ${teacher.onboardStatus}"),
                              ],
                            ),
                          )
                        ],
                      ),
                      // Display additional details or comments as needed
                    ],
                  );
                } else {
                  return const Center(child: Text('Teacher not found'));
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CommentForm(),
          ),
        ],
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
        bottom: MediaQuery.of(context).viewInsets.bottom, // Make room for the keyboard
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
                    style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Post a Review",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _review = value ?? '',
                    validator: (value) => value == null || value.trim().isEmpty ? 'Please enter a review' : null,
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
