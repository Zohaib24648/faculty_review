import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Post.dart';
import '../Providers/PostsProvider.dart';
import 'PostPage.dart';

class HomeFeed extends ConsumerWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeFeed'),
      ),
      body: postsAsyncValue.when(
        data: (posts) => _buildPostsList(posts),
        loading: () => const CircularProgressIndicator(),
        error: (error, _) => Text('Error: $error'),
      ),
    );
  }

  Widget _buildPostsList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final id = post.id;
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostPage(postId: id), // Ensure this matches the parameter expected by PostPage
              ),
            );
          },
            // leading: post.attachments.isNotEmpty
            //     ? Image.network(post.attachments[0], width: 100, fit: BoxFit.cover)
            //     : const SizedBox(width: 100, child: Center(child: Icon(Icons.image_not_supported))),
            title: Text(post.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.content),
                const SizedBox(height: 10),
                Text('By ${post.createdBy}'),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 8.0,
                  children: post.tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thumb_up, color: Colors.blue),
                Text('${post.upvotes}'),
                const Icon(Icons.thumb_down, color: Colors.red),
                Text('${post.downvotes}'),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
