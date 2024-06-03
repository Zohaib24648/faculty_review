import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../Models/Teacher.dart';
import 'token_notifier.dart';
import 'package:faculty_review/constants.dart';

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  final dio = ref.watch(dioProvider);
  final token = ref.read(tokenProvider);

  if (token == null) {
    throw Exception('User not authenticated');
  }

  try {
    final response = await dio.get(
      '$baseUrl/api/teachers/getallteachers',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map<Teacher>((json) => Teacher.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teachers');
    }
  } catch (e) {
    throw Exception('Failed to load teachers: $e');
  }
});