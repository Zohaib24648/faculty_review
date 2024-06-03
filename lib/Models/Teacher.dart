
class Teacher {
  final String id;
  final String name;
  final String title;
  final String email;
  final String overview;
  final List<String> coursesTaught;
  final List<String> coursesTaughtIDs;
  final List<String> ratedBy;
  final List<dynamic> ratings;
  final int totalRatings;
  final String department;
  final String specialization;
  final String onboardStatus;
  final String imageFile;
  final String createdBy;
  final String modifiedBy;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final bool isDeleted;

  Teacher({
    required this.id,
    required this.name,
    this.title = 'Instructor',
    this.email = '',
    this.overview = '',
    this.coursesTaught = const [],
    this.coursesTaughtIDs = const [],
    this.ratedBy = const [],
    this.ratings = const [0.0, 0.0, 0.0, 0.0],
    this.totalRatings = 0,
    this.department = '',
    this.specialization = '',
    this.onboardStatus = 'Available',
    this.imageFile = '',
    this.createdBy = '',
    this.modifiedBy = '',
    required this.createdAt,
    required this.modifiedAt,
    this.isDeleted = false,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'] as String,
      name: json['Name'] as String,
      title: json['Title'] as String? ?? 'Instructor',
      email: json['Email'] as String? ?? '',
      overview: json['Overview'] as String? ?? '',
      coursesTaught: (json['Courses Taught'] as List).map((item) => item as String).toList(),
      coursesTaughtIDs: (json['CoursesTaughtIDs'] as List).map((item) => item as String).toList(),
      ratedBy: (json['RatedBy'] as List).map((item) => item as String).toList(),
      ratings: (json['Ratings'] as List).map((item) => item as dynamic).toList(),
      totalRatings: json['TotalRatings'] as int? ?? 0,
      department: json['Department'] as String? ?? '',
      specialization: json['Specialization'] as String? ?? '',
      onboardStatus: json['OnboardStatus'] as String? ?? 'Available',
      imageFile: json['ImageFile'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      modifiedBy: json['modifiedBy'] as String? ?? '',
      createdAt: json['createdAt'] == null ? DateTime.now() : DateTime.parse(json['createdAt']),
      modifiedAt: json['modifiedAt'] == null ? DateTime.now() : DateTime.parse(json['modifiedAt']),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Name': name,
      'Title': title,
      'Email': email,
      'Overview': overview,
      'Courses Taught': coursesTaught,
      'CoursesTaughtIDs': coursesTaughtIDs,
      'RatedBy': ratedBy,
      'Ratings': ratings,
      'TotalRatings': totalRatings,
      'Department': department,
      'Specialization': specialization,
      'OnboardStatus': onboardStatus,
      'ImageFile': imageFile,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}
