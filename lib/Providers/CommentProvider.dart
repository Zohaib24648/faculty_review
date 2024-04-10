import 'package:faculty_review/Models/Comment.dart';
import 'package:faculty_review/Models/Teacher.dart';
import 'package:faculty_review/mongodbconnection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentProvider = FutureProvider.family<List<Comment>, String>((ref, teacherId) async {
  MongodbConnection mongodb = MongodbConnection.instance;
  final something = mongodb.allTeacherParentReviews(teacherId);
  print(something.toString());
  return something;
});
