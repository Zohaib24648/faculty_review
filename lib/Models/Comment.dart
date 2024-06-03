import 'package:mongo_dart/mongo_dart.dart';

class Comment {
  final ObjectId id;
  final int erp;
  final String name;
  final ObjectId? parentId;
  final String comment;
  final bool anonymous;
  final ObjectId? teacherId; // Make teacherId nullable
  final ObjectId? courseId;
  final int upVotes;
  final List<ObjectId> upVotedBy;
  final List<ObjectId> downVotedBy;
  final int downVotes;
  final String createdBy;
  final String modifiedBy;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final bool isDeleted;

  Comment({
    required this.id,
    required this.erp,
    required this.name,
    this.parentId,
    required this.comment,
    required this.anonymous,
    this.teacherId, // Nullable
    this.courseId,
    required this.upVotes,
    required this.upVotedBy,
    required this.downVotedBy,
    required this.downVotes,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.isDeleted,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: ObjectId.parse(json['_id'] as String),
      erp: json['erp'] as int,
      name: json['name'] as String,
      parentId: json['parent_id'] != null ? ObjectId.parse(json['parent_id'] as String) : null,
      comment: json['comment'] as String,
      anonymous: json['anonymous'] as bool,
      teacherId: json['teacher_id'] != null ? ObjectId.parse(json['teacher_id'] as String) : null, // Handle nullable teacherId
      courseId: json['course_id'] != null ? ObjectId.parse(json['course_id'] as String) : null,
      upVotes: json['upvotes'] as int,
      upVotedBy: json['upvotedBy'] != null ? List<ObjectId>.from(json['upvotedBy'].map((id) => ObjectId.parse(id as String))) : [],
      downVotedBy: json['downvotedBy'] != null ? List<ObjectId>.from(json['downvotedBy'].map((id) => ObjectId.parse(id as String))) : [],
      downVotes: json['downvotes'] as int,
      createdBy: json['createdby'] as String,
      modifiedBy: json['modifiedby'] as String,
      createdAt: DateTime.parse(json['createdat']),
      modifiedAt: DateTime.parse(json['modifiedat']),
      isDeleted: json['isDeleted'] as bool,
    );
  }
}
