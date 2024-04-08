import 'package:faculty_review/Models/Teacher.dart';
import 'package:faculty_review/mongodbconnection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  MongodbConnection mongodb = MongodbConnection.instance; // Use the singleton instance
  var something = await mongodb.allTeachersCatalogue();
  return something;
});
