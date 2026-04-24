import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reading_session.dart';
import '../models/user_settings.dart';

class StorageService {
  static const String _settingsKey = 'user_settings';
  static const String _sessionsKey = 'reading_sessions';
  static const String _bookmarkKey = 'current_bookmark';

  Future<void> saveSettings(UserSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }

  Future<UserSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_settingsKey);
    if (jsonString != null) {
      return UserSettings.fromJson(jsonDecode(jsonString));
    }
    return UserSettings(
      studentName: 'Öğrenci',
      dailyGoalMinutes: 10,
      fontSize: 'medium',
      ttsEnabled: true,
      breakDurationMinutes: 5,
    );
  }

  Future<void> saveBookmark(int paragraphIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_bookmarkKey, paragraphIndex);
  }

  Future<int> getBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_bookmarkKey) ?? 0;
  }
  
  Future<void> saveSession(ReadingSession session) async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = await getSessions();
    sessions.add(session);
    
    final jsonList = sessions.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_sessionsKey, jsonList);
  }

  Future<List<ReadingSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_sessionsKey);
    if (jsonList != null) {
      return jsonList.map((str) => ReadingSession.fromJson(jsonDecode(str))).toList();
    }
    return [];
  }
  
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
