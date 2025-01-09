import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String? id;
  final String title;
  final String? content;
  final String? imageUrl;
  final DateTime? createdAt;

  const Note({
    this.id,
    required this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
  });
  @override
  List<Object?> get props => [id, title, content, imageUrl, createdAt];

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (content != null) 'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
