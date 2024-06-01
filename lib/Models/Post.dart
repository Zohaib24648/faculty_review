class Post {
  final String id;
  final String title;
  final String content;
  final String createdBy;
  final List<String> tags;
  final int upvotes;
  final int downvotes;
  final List<String> upvotedBy;
  final List<String> downvotedBy;
  final String visibility;
  final bool isDeleted;
  final List<String> attachments;
  final List<String> comments;  // Changed from List<Comment> to List<String>
  final DateTime createdAt;
  final DateTime modifiedAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.createdBy,
    required this.tags,
    required this.upvotes,
    required this.downvotes,
    required this.upvotedBy,
    required this.downvotedBy,
    required this.visibility,
    required this.isDeleted,
    required this.attachments,
    required this.comments,  // Adjusted type
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      createdBy: json['createdBy'],
      tags: List<String>.from(json['tags']),
      upvotes: json['upvotes'],
      downvotes: json['downvotes'],
      upvotedBy: List<String>.from(json['upvotedBy']),
      downvotedBy: List<String>.from(json['downvotedBy']),
      visibility: json['visibility'],
      isDeleted: json['isDeleted'],
      attachments: List<String>.from(json['attachments']),
      comments: List<String>.from(json['comments']),  // Directly using List<String>
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
    );
  }
}
