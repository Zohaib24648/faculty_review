class Comment {
  final String id;
  final int erp;
  final String name;
  final String? parentId; // Nullable because it can be null
  final String comment;
  final List<int> rating;
  final bool anonymous;
  final int teacherId;
  final int courseId;
  final int upvotes;
  final List<dynamic> upvotedBy; // Using dynamic because the type is not specified
  final List<dynamic> downvotedBy; // Using dynamic because the type is not specified
  final int downvotes;
  final String createdBy;
  final String modifiedBy;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final bool isDeleted;
  final int version;

  Comment({
    required this.id,
    required this.erp,
    required this.name,
    this.parentId,
    required this.comment,
    required this.rating,
    required this.anonymous,
    required this.teacherId,
    required this.courseId,
    required this.upvotes,
    required this.upvotedBy,
    required this.downvotedBy,
    required this.downvotes,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.isDeleted,
    required this.version,
  });

  // Factory constructor for creating a new FeedbackItem instance from a map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      erp: json['erp'],
      name: json['name'],
      parentId: json['parent_id'],
      comment: json['comment'],
      rating: List<int>.from(json['rating']),
      anonymous: json['anonymous'],
      teacherId: json['teacher_id'],
      courseId: json['course_id'],
      upvotes: json['upvotes'],
      upvotedBy: json['upvotedBy'],
      downvotedBy: json['downvotedBy'],
      downvotes: json['downvotes'],
      createdBy: json['createdby'],
      modifiedBy: json['modifiedby'],
      createdAt: DateTime.parse(json['createdat']),
      modifiedAt: DateTime.parse(json['modifiedat']),
      isDeleted: json['isDeleted'],
      version: json['__v'],
    );
  }
}
