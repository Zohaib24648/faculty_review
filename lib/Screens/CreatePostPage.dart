import 'package:faculty_review/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/PostsProvider.dart';
import 'MainScree.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _anonymous = false;
  String _visibility = 'Public';

  void _submitPost() async {
    if (_formKey.currentState!.validate()) {
      final postData = {
        'title': _titleController.text,
        'content': _contentController.text,
        'visibility': _visibility,
        'anonymous': _anonymous,
        'attachments': ["http://example.com/attachment1.jpg"],
      };
      print(postData.toString());

      try {
        final success = await ref.read(createPostProvider(postData).future);
        if (success) {
          print('Post created successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post created successfully')),
          );
          // Clear the form
          _titleController.clear();
          _contentController.clear();
          ref.refresh(postsProvider);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create post')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Create Post', style: TextStyle(color: brownColor)),
      //   // backgroundColor: brownColor,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Create a New Post',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: brownColor),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _visibility,
                  decoration: InputDecoration(
                    labelText: 'Visibility',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Public', 'Private']
                      .map((visibility) => DropdownMenuItem(
                    value: visibility,
                    child: Text(visibility),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _visibility = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                SwitchListTile(
                  title: Text('Post anonymously'),
                  value: _anonymous,
                  onChanged: (value) {
                    setState(() {
                      _anonymous = value;
                    });
                  },
                  activeColor: brownColor,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text('Create Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
