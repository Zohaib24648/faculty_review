import 'package:mongo_dart/mongo_dart.dart';

class Teacher {
  final String id;
  final String name;
  final String title;
  final String email;
  final String overview;
  final List<dynamic> coursesTaught;
  final String department;
  final String specialization;
  final String onboardStatus;
  final String imageFile;
  final List<ObjectId> coursesTaughtIDs;
  final DateTime createdAt;
  final String createdBy;
  final bool isDeleted;
  final DateTime modifiedAt;
  final String modifiedBy;
  final List<ObjectId> ratedBy;
  final List<dynamic> ratings;
  final int totalRatings;

  Teacher({
    required this.id,
    required this.name,
    required this.title,
    required this.email,
    required this.overview,
    required this.coursesTaught,
    required this.department,
    required this.specialization,
    required this.onboardStatus,
    required this.imageFile,
    required this.coursesTaughtIDs,
    required this.createdAt,
    required this.createdBy,
    required this.isDeleted,
    required this.modifiedAt,
    required this.modifiedBy,
    required this.ratedBy,
    required this.ratings,
    required this.totalRatings,
  });
  factory Teacher.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Teacher(
        id: json['_id'].$oid.toString(), // Convert ObjectId to string
      name: json['Name']?.toString() ?? '', // Ensure value is converted to String
      title: json['Title']?.toString() ?? '',
      email: json['Email']?.toString() ?? '',
      overview: json['Overview']?.toString() ?? '',
      coursesTaught: json['Courses Taught'] as List<dynamic> ,
      department: json['Department']?.toString() ?? '',
      specialization: json['Specialization']?.toString() ?? '',
      onboardStatus: json['Onboard Status']?.toString() ?? '',
      imageFile: json['ImageFile']?.toString() ?? '',
      coursesTaughtIDs: (json['CoursesTaughtIDs'] as List? ?? []).map((item) => item as ObjectId).toList(),
      createdAt: DateTime.parse(json['CreatedAt']?.toString() ?? '1970-01-01T00:00:00Z'),
      createdBy: json['CreatedBy']?.toString() ?? '',
      isDeleted: json['IsDeleted'] as bool? ?? false,
      modifiedAt: DateTime.parse(json['ModifiedAt']?.toString() ?? '1970-01-01T00:00:00Z'),
      modifiedBy: json['ModifiedBy']?.toString() ?? '',
      ratedBy: (json['RatedBy'] as List? ?? []).map((item) => item as ObjectId).toList(),
      ratings: json['Ratings'] as List<dynamic>,
      totalRatings: json['TotalRatings'] as int


    );

  }


}
