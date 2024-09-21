import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Models/Post.dart';
import 'package:faculty_review/Providers/PostsProvider.dart';
import 'PostPage.dart';

class HomeFeed extends ConsumerWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      body: postsAsyncValue.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () async {
            // Refresh the posts by calling the refresh method on the provider
            ref.refresh(postsProvider);
          },
          child: _buildPostsList(posts),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Text('Error: $error'),
      ),
    );
  }

  Widget _buildPostsList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return InkWell(
          onTap: () {
            // Define what happens when the tile is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostPage(postId:post.id,),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By: ${post.createdBy}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        color: Colors.blue,
                        onPressed: () {
                          // Upvote logic
                        },
                      ),
                      Text(
                        '${post.upvotes}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        color: Colors.red,
                        onPressed: () {
                          // Downvote logic
                        },
                      ),
                      Text(
                        '${post.downvotes}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Comment logic
                        },
                        icon: const Icon(Icons.comment, size: 20),
                        label: Text(post.comments.length.toString()),
                      ),
                      IconButton(
                        onPressed: () {
                          // Share logic
                        },
                        icon: const Icon(Icons.share, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
