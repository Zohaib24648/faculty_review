import 'package:faculty_review/Providers/token_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Post.dart';
import '../Services/api_service.dart';
import '../models/comment.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.read(dioProvider); // Ensure you have a dioProvider that supplies Dio instance
  return ApiService(dio);
});

final commentsProvider = FutureProvider.family<List<Comment>, String>((ref, teacherId) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getCommentsByTeacher(teacherId);
});


final commentProvider = FutureProvider.family<Comment, String>((ref, commentId) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchCommentById(commentId);
});

final postCommentProvider = Provider<Future<bool> Function(String, String, {String? parentId})>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return (String teacherId, String comment, {String? parentId}) async {
    return await apiService.postComment(teacherId, comment, parentId: parentId);
  };


});

final postProvider = FutureProvider.family<Post, String>((ref, postId) async {
final apiService = ref.read(apiServiceProvider);
return await apiService.fetchPostById(postId);
}

);
