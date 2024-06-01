import 'package:dio/dio.dart';
import 'package:faculty_review/Providers/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Services/api_service.dart';

import '../Models/Post.dart';  // Ensure this import is correct

// Provider for Dio to be used across the application

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.watch(dioProvider));
});

// Provider for fetching posts
final postsProvider = FutureProvider<List<Post>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  final posts = await apiService.fetchPosts();
  return posts;
});

// PostsProvider.dart
    final postProvider = FutureProvider.family<Post, String>((ref, postId) async {
      final apiService = ref.read(apiServiceProvider);
      return await apiService.fetchPostById(postId);
    });
