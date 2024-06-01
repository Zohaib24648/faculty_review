import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Models/Post.dart';
import 'package:faculty_review/Services/api_service.dart';
import 'CommentProvider.dart';


// Provider for fetching posts
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchPosts();
});

// Provider for fetching a post by ID
final postProvider = FutureProvider.family<Post, String>((ref, postId) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchPostById(postId);
});
