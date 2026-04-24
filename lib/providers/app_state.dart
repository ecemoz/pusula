import 'package:flutter/material.dart';
import '../models/user_settings.dart';
import '../models/reading_session.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  UserSettings? _settings;
  List<ReadingSession> _sessions = [];
  int _todayReadingMinutes = 0;
  
  UserSettings? get settings => _settings;
  List<ReadingSession> get sessions => _sessions;
  int get todayReadingMinutes => _todayReadingMinutes;

  AppState() {
    _init();
  }

  Future<void> _init() async {
    _settings = await _storageService.getSettings();
    _sessions = await _storageService.getSessions();
    _calculateTodayReading();
    notifyListeners();
  }

  void _calculateTodayReading() {
    final today = DateTime.now();
    _todayReadingMinutes = _sessions
        .where((s) => s.date.year == today.year && s.date.month == today.month && s.date.day == today.day)
        .fold(0, (sum, item) => sum + item.durationMinutes);
  }

  Future<void> updateSettings(UserSettings newSettings) async {
    _settings = newSettings;
    await _storageService.saveSettings(newSettings);
    notifyListeners();
  }

  Future<void> addSession(ReadingSession session) async {
    _sessions.add(session);
    await _storageService.saveSession(session);
    _calculateTodayReading();
    notifyListeners();
  }
}
