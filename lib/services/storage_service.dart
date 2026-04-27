import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reading_content.dart';
import '../models/reading_session.dart';
import '../models/user_settings.dart';

class StorageService {
  static const String _settingsKey = 'user_settings';
  static const String _sessionsKey = 'reading_sessions';
  static const String _bookmarkKey = 'current_bookmark';
  static const String _libraryKey = 'reading_library';
  static const String _bookmarksByContentKey = 'content_bookmarks';

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

  Future<void> saveBookmarkForContent(
    String contentId,
    int paragraphIndex,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final map = await getBookmarksByContent();
    map[contentId] = paragraphIndex;
    await prefs.setString(_bookmarksByContentKey, jsonEncode(map));
  }

  Future<int> getBookmarkForContent(String contentId) async {
    final map = await getBookmarksByContent();
    return map[contentId] ?? await getBookmark();
  }

  Future<Map<String, int>> getBookmarksByContent() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_bookmarksByContentKey);
    if (jsonString == null) {
      return {};
    }

    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  Future<void> saveLibraryContents(List<ReadingContent> contents) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = contents
        .map((content) => jsonEncode(content.toJson()))
        .toList();
    await prefs.setStringList(_libraryKey, jsonList);
  }

  Future<List<ReadingContent>> getLibraryContents() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_libraryKey);
    if (jsonList == null || jsonList.isEmpty) {
      return [];
    }

    return jsonList
        .map(
          (jsonString) => ReadingContent.fromJson(
            jsonDecode(jsonString) as Map<String, dynamic>,
          ),
        )
        .toList();
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
      return jsonList
          .map((str) => ReadingSession.fromJson(jsonDecode(str)))
          .toList();
    }
    return [];
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
