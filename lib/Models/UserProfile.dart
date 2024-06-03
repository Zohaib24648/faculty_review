class UserProfile {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final int erp;
  final String profilePicture;
  final List<String> roles;
  final List<dynamic> savedComments;
  final List<dynamic> savedTeachers;
  final List<dynamic> savedCourses;
  final bool isDeleted;
  final String createdBy;
  final String modifiedBy;
  final DateTime createdAt;
  final DateTime modifiedAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.erp,
    required this.profilePicture,
    required this.roles,
    required this.savedComments,
    required this.savedTeachers,
    required this.savedCourses,
    required this.isDeleted,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      erp: json['erp'],
      profilePicture: json['profile_picture'],
      roles: List<String>.from(json['roles']),
      savedComments: List<dynamic>.from(json['saved_comments']),
      savedTeachers: List<dynamic>.from(json['saved_teachers']),
      savedCourses: List<dynamic>.from(json['saved_courses']),
      isDeleted: json['isdeleted'],
      createdBy: json['createdby'],
      modifiedBy: json['modifiedby'],
      createdAt: DateTime.parse(json['createdat']),
      modifiedAt: DateTime.parse(json['modifiedat']),
    );
  }
}
