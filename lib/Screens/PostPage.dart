import 'package:faculty_review/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Models/Post.dart';
import 'package:faculty_review/Models/Comment.dart';
import 'package:faculty_review/Providers/CommentProvider.dart';
import 'package:faculty_review/Providers/PostsProvider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostPage extends ConsumerStatefulWidget {
  final String postId;

  const PostPage({required this.postId, super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _postComment(String postId) async {
    if (_commentController.text.isNotEmpty) {
      final apiService = ref.read(apiServiceProvider);
      bool success = await apiService.postCommentOnPost(postId, _commentController.text, false);
      if (success) {
        ref.refresh(postProvider(postId));
        _commentController.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comment posted successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to post comment')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postAsyncValue = ref.watch(postProvider(widget.postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: brownColor,
        foregroundColor: Colors.white,
      ),
      body: postAsyncValue.when(
        data: (Post post) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: brownColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    post.content,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Created by: ${post.createdBy}"),
                        Text(timeago.format(post.createdAt)),
                        // Text("Visibility: ${post.visibility}"),
                      ],
                    ),
                  ),
                  const Divider(),
                  _buildCommentsSection(post.comments),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: _buildCommentInput(widget.postId),
    );

  }

  Widget _buildCommentsSection(List<String> commentIds) {
    if (commentIds.isEmpty) {
      return const Center(child: Text('No comments available.'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: commentIds.length,
      itemBuilder: (context, index) {
        final commentId = commentIds[index];
        final commentAsyncValue = ref.watch(commentProvider(commentId));
        return commentAsyncValue.when(
          data: (Comment comment) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(comment.comment, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('By: ${comment.name}'),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildCommentInput(String postId) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.deepPurple),
              onPressed: () => _postComment(postId),
            ),
          ],
        ),
      ),
    );
  }
}
