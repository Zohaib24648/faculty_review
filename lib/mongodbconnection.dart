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


  Future<List> allTeacher() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('teachers').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Method to fetch replies for a specific parent comment
  Future<List<Map<String, dynamic>>> fetchReplies(int parentId) async {
    var db = await getDb(); // Use the singleton Db instance
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


  Future<List> allParentReviews(String _id) async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('comments').find( {'Parent_id':null , '_id': _id} ).toList();
      print(data);
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List> Teachers() async {
    var db = await getDb(); // Use the singleton Db instance
    try {
      List<dynamic> data = await db.collection('teachers').find().toList();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>?> FindTeacher(String email) async {
    print(email); // For debugging, consider removing later
    var db = await getDb();
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
  }}
