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
  final int version;
  final DateTime createdAt;
  final String createdBy;
  final bool isDeleted;
  final DateTime modifiedAt;
  final String modifiedBy;

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
    required this.version,
    required this.createdAt,
    required this.createdBy,
    required this.isDeleted,
    required this.modifiedAt,
    required this.modifiedBy,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id']['\$oid'] as String,
      name: json['Name'] as String,
      title: json['Title'] as String,
      email: json['Email'] as String,
      overview: json['Overview'] as String,
      coursesTaught: List<String>.from(json['Courses Taught'] as List),
      department: json['Department'] as String,
      specialization: json['Specialization'] as String,
      onboardStatus: json['Onboard Status'] as String,
      imageFile: json['ImageFile'] as String,
      coursesTaughtIDs: (json['CoursesTaughtIDs'] as List).map((item) => item['\$oid'] as String).toList(),
      version: json['__v'] as int,
      createdAt: DateTime.parse(json['createdAt']['\$date'] as String),
      createdBy: json['createdBy'] as String,
      isDeleted: json['isDeleted'] as bool,
      modifiedAt: DateTime.parse(json['modifiedAt']['\$date'] as String),
      modifiedBy: json['modifiedBy'] as String,
    );
  }
}
