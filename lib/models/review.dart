import 'author_details.dart';

class Review {
  String author;
  AuthorDetails authorDetails;
  String content;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  String url;

  Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      authorDetails: AuthorDetails.fromJson(json['author_details']),
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'author_details': authorDetails.toJson(),
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'url': url,
    };
  }
}
