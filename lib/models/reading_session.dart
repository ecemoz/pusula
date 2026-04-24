class ReadingSession {
  final String id;
  final DateTime date;
  final int durationMinutes;
  final int completedParagraphs;
  final int rereadCount;
  final int bookmarkIndex;

  ReadingSession({
    required this.id,
    required this.date,
    required this.durationMinutes,
    required this.completedParagraphs,
    required this.rereadCount,
    required this.bookmarkIndex,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'durationMinutes': durationMinutes,
        'completedParagraphs': completedParagraphs,
        'rereadCount': rereadCount,
        'bookmarkIndex': bookmarkIndex,
      };

  factory ReadingSession.fromJson(Map<String, dynamic> json) => ReadingSession(
        id: json['id'],
        date: DateTime.parse(json['date']),
        durationMinutes: json['durationMinutes'],
        completedParagraphs: json['completedParagraphs'],
        rereadCount: json['rereadCount'],
        bookmarkIndex: json['bookmarkIndex'],
      );
}
