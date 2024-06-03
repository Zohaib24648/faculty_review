import 'package:dio/dio.dart';
import 'package:faculty_review/Models/Post.dart';
import 'package:faculty_review/Models/Comment.dart';
import 'package:faculty_review/constants.dart';

import '../Models/UserProfile.dart';
import '../Providers/token_notifier.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Comment>> getCommentsByTeacher(String teacherId) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/comments/getcommentsofteacher',
        data: {'teacher_id': teacherId},
      );
      return (response.data as List).map((json) => Comment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch comments: ${e.message}');
    }
  }
  Future<bool> postComment(String teacherId, String comment, {String? parentId}) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/comments/postcomment',
        data: {
          'teacher_id': teacherId,
          'comment': comment,
          'parentId': parentId,
          'anonymous': false,
        },
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> postCommentOnPost(String postId, String commentText, bool anonymous) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/comments/postCommentOnPost',
        data: {
          'post_id': postId,
          'commentText': commentText,
          'anonymous': anonymous,
        },
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception('Failed to post comment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to post comment: ${e.toString()}');
    }
  }

  Future<Post> fetchPostById(String postId) async {
    try {
      final response = await dio.post('$baseUrl/api/posts/getpostbyid', data: {'postId': postId});
      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('Failed to load post: Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching post by ID: ${e.toString()}');
      throw Exception('Failed to load post due to an error: ${e.toString()}');
    }
  }

  Future<bool> createPost({
    required String title,
    required String content,
    required String visibility,
    required bool anonymous,
    List<String>? attachments,
  }) async {
    try {
      const url = '$baseUrl/api/posts/createpost';
      final response = await dio.post(url,
        data: {
          'title': title,
          'content': content,
          'visibility': visibility,
          'anonymous': anonymous,
          'attachments': attachments ?? [],
        },
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception('Failed to create post: ${e.message}');
    }
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get('$baseUrl/api/posts/getposts');
      if (response.statusCode == 200) {
        return (response.data as List).map((postJson) => Post.fromJson(postJson)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load posts');
    }
  }



  Future<UserProfile> getUserProfile() async {
    try {
      final response = await dio.get('$baseUrl/api/users/getuserprofile');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch user profile: ${e.message}');
    }
  }


  Future<Comment> fetchCommentById(String commentId) async {
    try {
      final response = await dio.post('$baseUrl/api/comments/getcommentbyid', data: {'commentId': commentId});
      if (response.statusCode == 200) {
        return Comment.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception('Comment not found');
      } else {
        throw Exception('Failed to load comment: Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching comment by ID: ${e.toString()}');
      throw Exception('Failed to load comment due to an error: ${e.toString()}');
    }
  }
}