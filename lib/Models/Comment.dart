import 'package:mongo_dart/mongo_dart.dart';

class Comment {
  final ObjectId id;
  final int erp;
  final String name;
  final String? parentId; // Nullable because it can be null
  final String comment;
  final List<dynamic> rating;
  final bool anonymous;
  final ObjectId teacherId;
  final ObjectId courseId;
  final int upVotes;
  final List<dynamic> upVotedBy; // Using dynamic because the type is not specified
  final List<dynamic> downVotedBy; // Using dynamic because the type is not specified
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
    required this.rating,
    required this.anonymous,
    required this.teacherId,
    required this.courseId,
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

  // Factory constructor for creating a new FeedbackItem instance from a map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as ObjectId,
      erp: json['erp'] as int,
      name: json['name'] as String,
      parentId: json['parent_id'] as String?,
      comment: json['comment'] as String,
      rating: List<dynamic>.from(json['rating'] as List),
      anonymous: json['anonymous'] as bool,
      teacherId: json['teacher_id'] as ObjectId,
      courseId: json['course_id'] as ObjectId,
      upVotes: json['upvotes'] as int,
      upVotedBy: json['upvotedBy'] as List<dynamic>,
      downVotedBy: json['downvotedBy'] as List<dynamic>,
      downVotes: json['downvotes'] as int,
      createdBy: json['createdby'] as String,
      modifiedBy: json['modifiedby'] as String,
      createdAt: json['createdat'] ,
      modifiedAt: json['modifiedat'],
      isDeleted: json['isDeleted'] as bool,
    );
  }


}
