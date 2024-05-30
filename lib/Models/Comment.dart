import 'package:mongo_dart/mongo_dart.dart';

class Comment {
  final ObjectId id;
  final int erp;
  final String name;
  final ObjectId? parentId; // Nullable because it can be null
  final String comment;
  final bool anonymous;
  final ObjectId teacherId;
  final ObjectId? courseId; // Make courseId nullable
  final int upVotes;
  final List<ObjectId> upVotedBy; // Using dynamic because the type is not specified
  final List<ObjectId> downVotedBy; // Using dynamic because the type is not specified
  final int downVotes;
  final String createdBy;
  final String modifiedBy;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final bool isDeleted;
  // final int version;

  Comment({
    required this.id,
    required this.erp,
    required this.name,
    this.parentId,
    required this.comment,
    required this.anonymous,
    required this.teacherId,
    this.courseId, // Nullable parameter
    required this.upVotes,
    required this.upVotedBy,
    required this.downVotedBy,
    required this.downVotes,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.isDeleted,
    // required this.version,
  });

  // Factory constructor for creating a new Comment instance from a map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: ObjectId.parse(json['_id'] as String),  // Convert String to ObjectId
      erp: json['erp'] as int,
      name: json['name'] as String,
      parentId: json['parent_id'] != null ? ObjectId.parse(json['parent_id'] as String) : null,  // Handle nullable ObjectId
      comment: json['comment'] as String,
      anonymous: json['anonymous'] as bool,
      teacherId: ObjectId.parse(json['teacher_id'] as String),  // Convert String to ObjectId
      courseId: json['course_id'] != null ? ObjectId.parse(json['course_id'] as String) : null,  // Handle nullable ObjectId
      upVotes: json['upvotes'] as int,
      upVotedBy: json['upvotedBy'] != null ? List<ObjectId>.from(json['upvotedBy'].map((id) => ObjectId.parse(id as String))) : [],  // Provide default empty list if null
      downVotedBy: json['downvotedBy'] != null ? List<ObjectId>.from(json['downvotedBy'].map((id) => ObjectId.parse(id as String))) : [],  // Provide default empty list if null
      downVotes: json['downvotes'] as int,
      createdBy: json['createdby'] as String,
      modifiedBy: json['modifiedby'] as String,
      createdAt: DateTime.parse(json['createdat']),
      modifiedAt: DateTime.parse(json['modifiedat']),
      isDeleted: json['isDeleted'] as bool,
    );
  }
}
