import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';  // Add this for debugPrint
import '../models/teacher.dart';
import '../models/comment.dart';
import '../constants.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Teacher>> getAllTeachers() async {
    try {
      final response = await dio.get('$baseUrl/teachers');
      return (response.data as List).map((json) => Teacher.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch teachers: ${e.message}');
    }
  }

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
}
