class Note {
  final String? id;
  final String title;
  final String? content;
  final String? imageUrl;
  final DateTime? createdAt;

  Note({
    this.id,
    required this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
  });

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
