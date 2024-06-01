import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Models/Post.dart';
import 'package:faculty_review/Models/Comment.dart';
import 'package:faculty_review/Providers/CommentProvider.dart';
import 'package:faculty_review/Providers/PostsProvider.dart';
import 'package:faculty_review/Services/api_service.dart';


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
      appBar: AppBar(title: const Text('Post Details')),
      body: postAsyncValue.when(
        data: (Post post) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(post.content),
                ),
                const SizedBox(height: 10),
                Divider(),
                ListTile(
                  title: const Text("Post Details"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Created by: ${post.createdBy}"),
                      Text("On: ${post.createdAt.toLocal()}"),
                      Text("Visibility: ${post.visibility}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: post.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                if (post.attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Attachments", style: TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children: post.attachments.map((attachment) => Image.network(attachment)).toList(),
                        ),
                      ],
                    ),
                  ),
                _buildCommentsSection(post.comments),
                _buildCommentInput(post.id),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildCommentsSection(List<String> commentIds) {
    if (commentIds.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text('No comments available.')),
      );
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
            return ListTile(
              title: Text(comment.comment),
              subtitle: Text('By: ${comment.name}'),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildCommentInput(String postId) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: 'Write a comment...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _postComment(postId),
            ),
          ),
        ),
      ),
    );
  }
}
