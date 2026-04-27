class ReadingContent {
  final String id;
  final String title;
  final List<String> paragraphs;
  final String summary;
  final DateTime fetchedAt;

  ReadingContent({
    required this.id,
    required this.title,
    required this.paragraphs,
    required this.summary,
    DateTime? fetchedAt,
  }) : fetchedAt = fetchedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'paragraphs': paragraphs,
    'summary': summary,
    'fetchedAt': fetchedAt.toIso8601String(),
  };

  factory ReadingContent.fromJson(Map<String, dynamic> json) => ReadingContent(
    id: json['id'] as String,
    title: json['title'] as String,
    paragraphs: (json['paragraphs'] as List<dynamic>).cast<String>(),
    summary: json['summary'] as String,
    fetchedAt: json['fetchedAt'] != null
        ? DateTime.parse(json['fetchedAt'] as String)
        : DateTime.now(),
  );
}
