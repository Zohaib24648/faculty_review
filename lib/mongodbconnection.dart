import 'package:mongo_dart/mongo_dart.dart';
class mongodbconnection {

   Future<List>  allteacher()async{
    var db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/FacultyReviews?retryWrites=true&w=majority&appName=UserLogins");
    await db.open();

    try {
      await db.open();
      print("Connected to the database");
      List<dynamic> data = await db.collection('Logins').find().toList();
      return data;
    }
    catch (e) {
      print(e);
      return [];
    }}

   Future<List>  allMajors()async{
     var db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/FacultyReviews?retryWrites=true&w=majority&appName=UserLogins");
     await db.open();

     try {
       await db.open();
       print("Connected to the database");
       List<dynamic> data = await db.collection('allMajors').find().toList();
       return data;
     }
     catch (e) {
       print(e);
       return [];
     }}

   Future<List>  allcourses()async{
     var db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/FacultyReviews?retryWrites=true&w=majority&appName=UserLogins");
     await db.open();

     try {
       await db.open();
       print("Connected to the database");
       List<dynamic> data = await db.collection('Courses').find().toList();
       return data;
     }
     catch (e) {
       print(e);
       return [];
     }}


  void main() async {
    var db = await Db.create("mongodb+srv://Zohaib24648:Zohaib24648@userlogins.94nzbbm.mongodb.net/FacultyReviews?retryWrites=true&w=majority&appName=UserLogins");
    await db.open();

    try {
      await db.open();
      print("Connected to the database");

      print( await db.collection('Logins').find().toList());

    }
    catch (e) {
      print(e);
    }
    try{await db.close(); print("Database Connection Closed");}
    catch(e){
      print(e);
    }
    catch(e){
      print(e);

    // Your code here
  }
}}