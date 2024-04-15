import 'package:faculty_review/Models/Teacher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  var dio = Dio(); // Create a Dio instance
  // Your JWT token
  String jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlcnAiOjEwMDAwLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInJvbGVzIjpbIlVzZXIiXSwiZmlyc3RuYW1lIjoiSm9obiIsImxhc3RuYW1lIjoiRG9lIiwiY3JlYXRlZEF0IjoiMjAyNC0wNC0xMFQxOTo1NTowMS41NjVaIiwiaWF0IjoxNzEyNzc4OTAxLCJleHAiOjE3MTI4NjUzMDF9.I39OtysTlQw9oPbvBODYr1Hbs7LHXPzFxWPu6nz7PbA";
var response;
  // Set the JWT token in the headers
  dio.options.headers["Authorization"] = "Bearer $jwtToken";
try {
  response = await dio.get('http://10.0.2.2:3001/api/teachers/getallteachers' );

} catch (e) {
print(e);
response = null;
}

  // Assuming the response data is a list of JSON objects representing teachers
  if (response.statusCode == 200) {
    List<Teacher> teachers = (response.data as List<dynamic>).map((teacher) {
      try {
        return Teacher.fromJson(teacher);
      } catch (e) {
        print("Error parsing teacher data: $e");
        return null; // Return null if there's an error parsing a teacher
      }
    }).where((teacher) => teacher != null).cast<Teacher>().toList(); // Filter out null values and cast to Teacher
    return teachers;
  } else {
    print("Error fetching teachers: ${response.statusCode}");
    return [];
  }
});
