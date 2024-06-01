import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Post.dart';
import '../Providers/token_notifier.dart';
import '../models/comment.dart';
import '../constants.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Comment>> getCommentsByTeacher(String teacherId) async {
    try {
      final response = await dio.post(
          '$baseUrl/api/comments/getcommentsofteacher',
          data: {'teacher_id': teacherId}
      );
      return (response.data as List).map((json) => Comment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch comments: ${e.message}');
    }
  }

  Future<bool> postComment( String comment,String teacherId, {String? parentId}) async {
    try {
      final response = await dio.post(
          '$baseUrl/api/comments/postcomment',
          data: {
            'teacher_id': teacherId,
            'comment': comment,
            'parentId': parentId,
            'anonymous': false,
          }
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception('Failed to post comment: ${e.message}');
    }
  }


  Future<bool> postCommentOnPost(String postId, String commentText, bool anonymous) async {
    try {
      final response = await dio.post(
          '$baseUrl/api/comments/postCommentOnPost',  // Adjust the endpoint as necessary
          data: {
            'post_id': postId,
            'commentText': commentText,
            'anonymous': anonymous,
          },
      );

      // Check if the response status code indicates a successful creation
      return response.statusCode == 201;
    } on DioException catch (e) {
      // Handle Dio-specific errors here
      throw Exception('Failed to post comment: ${e.message}');
    } catch (e) {
      // Handle any other errors that might occur
      throw Exception('Failed to post comment: ${e.toString()}');
    }
  }




  Future<Post> fetchPostById(String postId) async {
    try {
      // Ensure there's no double slashes in the URL
      final response = await dio.post('$baseUrl/api/posts/getpostbyid', data: {'postId': postId});
      if (response.statusCode == 200) {
        // Make sure the data format from JSON to Post object is correctly handled
        return Post.fromJson(response.data);
      } else {
        // Throw a more descriptive error
        throw Exception('Failed to load post: Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      // Print and rethrow to handle the exception outside this function if necessary
      print('Error fetching post by ID: ${e.toString()}');
      throw Exception('Failed to load post due to an error: ${e.toString()}');
    }
  }



  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get('$baseUrl/api/posts/getposts');
      if (response.statusCode == 200) {
        print(response.data);
        return (response.data as List).map((postJson) => Post.fromJson(postJson)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load posts');
    }
  }

  Future<Comment> fetchCommentById(String commentId) async {
    try {
      final response = await dio.post('$baseUrl/api/comments/getcommentbyid', data: {'commentId': commentId});
      if (response.statusCode == 200) {
        return Comment.fromJson(response.data);
      } else {
        throw Exception('Failed to load comment: Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching comment by ID: ${e.toString()}');
      throw Exception('Failed to load comment due to an error: ${e.toString()}');
    }
  }


}
