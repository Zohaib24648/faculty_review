
import 'dart:convert';

import 'package:faculty_review/Models/Comment.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:faculty_review/Models/Teacher.dart';
import 'package:faculty_review/Models/Comment.dart';
class MongodbConnection {
  static final MongodbConnection _instance = MongodbConnection._privateConstructor();
  static Db? _db;

  MongodbConnection._privateConstructor();

  static MongodbConnection get instance => _instance;

  static Future<Db> initializeConnection() async {
    if (_db == null) {
      _db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/AcademiQ?retryWrites=true&w=majority&appName=UserLogins");
      await _db!.open();
      print("Connected to the database");
    }
    return _db!;
  }

  Future<bool> postReview(String teacherId, String review) async {
    try {
    print("Review Submitted. the material is $teacherId and the review is $review");
      return true; // Return true on success
    } catch (e) {
      print(e); // Log the error
      return false; // Return false on failure
    }
  }


  Future<List<Teacher>> allTeachersCatalogue() async {
    var db = await initializeConnection();
    try {
      List<Map<String, dynamic>> teacherMaps = await db.collection('teachers').find().toList();
      List<Teacher> teachers = teacherMaps.map((map) {
        try {
          return Teacher.fromJson(map);
        } catch (e) {
          print("Error parsing teacher data: $e");
          return null; // Return null if there's an error parsing a teacher
        }
      }).where((teacher) => teacher != null).cast<Teacher>().toList(); // Filter out null values and cast to Teacher
      return teachers;
    } catch (e) {
      print(e);
      return [];
    }
  }





  // Method to fetch replies for a specific parent comment
  Future<List<Map<String, dynamic>>> fetchReplies(int parentId) async {
    var db = await initializeConnection(); // Use the singleton Db instance
    try {
      // Query the collection for comments with the specified Parent_id
      var data = await db.collection('comments').find({'parent_id': parentId}).toList();

      print(data); // Debugging: Print fetched replies
      return data;
    } catch (e) {
      print(e); // Error handling: Log the error
      return []; // Return an empty list on failure
    }
  }


  Future<List<Comment>> allTeacherParentReviews(String teacher_id) async {
    var db = await initializeConnection();
    List<Map<String, dynamic>> data = await db.collection('comments').find({'teacher_id': ObjectId.fromHexString(teacher_id)}).toList();

    List<Comment> comments = data.map((map) => Comment.fromJson(map)).toList();

    return comments;
  }




  Future<Map<String, dynamic>?> findTeacher(String email) async {
    print(email); // For debugging, consider removing later
    var db = await initializeConnection();
    try {
      var data = await db.collection('teachers').findOne({"Email": email});
      print(data); // For debugging, consider removing later
      return data;
    } catch (e) {
      print(e); // Consider how to handle errors more gracefully
      return null; // Indicate an error occurred
    }
  }




  Future<List> allMajors() async {
    var db = await initializeConnection(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('allMajors').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> allCourses() async {
    var db = await initializeConnection(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('Courses').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }}
