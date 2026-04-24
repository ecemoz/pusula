class UserSettings {
  final String studentName;
  final int dailyGoalMinutes;
  final String fontSize; // small, medium, large
  final bool ttsEnabled;
  final int breakDurationMinutes;

  UserSettings({
    required this.studentName,
    required this.dailyGoalMinutes,
    required this.fontSize,
    required this.ttsEnabled,
    required this.breakDurationMinutes,
  });

  Map<String, dynamic> toJson() => {
        'studentName': studentName,
        'dailyGoalMinutes': dailyGoalMinutes,
        'fontSize': fontSize,
        'ttsEnabled': ttsEnabled,
        'breakDurationMinutes': breakDurationMinutes,
      };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        studentName: json['studentName'] ?? 'Öğrenci',
        dailyGoalMinutes: json['dailyGoalMinutes'] ?? 10,
        fontSize: json['fontSize'] ?? 'medium',
        ttsEnabled: json['ttsEnabled'] ?? true,
        breakDurationMinutes: json['breakDurationMinutes'] ?? 5,
      );
}
