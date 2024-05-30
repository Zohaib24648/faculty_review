import 'package:mongo_dart/mongo_dart.dart';

class Teacher {
  final String id;
  final String name;
  final String title;
  final String email;
  final String overview;
  final List<String> coursesTaught;
  final String department;
  final String specialization;
  final String onboardStatus;
  final String imageFile;
  final List<String> coursesTaughtIDs;
  final DateTime createdAt;
  final String createdBy;
  final bool isDeleted;
  final DateTime modifiedAt;
  final String modifiedBy;
  final List<dynamic> ratedBy;
  final List<int> ratings;
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
    return Teacher(
      id: json['_id'].toString(), // Convert ObjectId to string
      name: json['Name']?.toString() ?? '', // Ensure value is converted to String
      title: json['Title']?.toString() ?? '',
      email: json['Email']?.toString() ?? '',
      overview: json['Overview']?.toString() ?? '',
      coursesTaught: List<String>.from(json['CoursesTaught'] ?? []), // Convert to List<String>
      department: json['Department']?.toString() ?? '',
      specialization: json['Specialization']?.toString() ?? '',
      onboardStatus: json['OnboardStatus']?.toString() ?? '',
      imageFile: json['ImageFile']?.toString() ?? '',
      coursesTaughtIDs: List<String>.from(json['CoursesTaughtIDs'] ?? []), // Convert to List<String>
      createdAt: DateTime.parse(json['createdAt']?.toString() ?? '1970-01-01T00:00:00Z'),
      createdBy: json['createdBy']?.toString() ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      modifiedAt: DateTime.parse(json['modifiedAt']?.toString() ?? '1970-01-01T00:00:00Z'),
      modifiedBy: json['modifiedBy']?.toString() ?? '',
      ratedBy: json['RatedBy'] ?? [],
      ratings: (json['Ratings'] as List<dynamic>).map((e) => (e is int) ? e : (e as num).toInt()).toList(), // Convert to List<int>
      totalRatings: (json['TotalRatings'] is int) ? json['TotalRatings'] : (json['TotalRatings'] as num).toInt(), // Ensure int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Name': name,
      'Title': title,
      'Email': email,
      'Overview': overview,
      'CoursesTaught': coursesTaught,
      'Department': department,
      'Specialization': specialization,
      'OnboardStatus': onboardStatus,
      'ImageFile': imageFile,
      'CoursesTaughtIDs': coursesTaughtIDs,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'isDeleted': isDeleted,
      'modifiedAt': modifiedAt.toIso8601String(),
      'modifiedBy': modifiedBy,
      'RatedBy': ratedBy,
      'Ratings': ratings,
      'TotalRatings': totalRatings,
    };
  }
}
