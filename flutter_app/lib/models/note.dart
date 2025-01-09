class Note {
  final String? id;
  final String title;
  final String? content;
  String? imageUrl;

  Note({
    this.id,
    required this.title,
    this.content,
    this.imageUrl,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (content != null) 'content': content,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
