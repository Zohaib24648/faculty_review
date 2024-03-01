import 'package:mongo_dart/mongo_dart.dart';

class MongodbConnection {
  static Db? _db; // Private static instance

  // Private constructor
  MongodbConnection._privateConstructor();

  // Public factory constructor
  factory MongodbConnection() {
    return MongodbConnection._privateConstructor();
  }

  // Initialize and/or get the Db instance
  static Future<Db> getDb() async {
    if (_db == null) {
      _db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/FacultyReviews?retryWrites=true&w=majority&appName=UserLogins");
      await _db!.open();
      print("Connected to the database");
    }
    return _db!;
  }

  Future<List> allTeacher() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('Logins').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<List> Teachers() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('Teachers').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List> allMajors() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('allMajors').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> allCourses() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('Courses').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
