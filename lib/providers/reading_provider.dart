import 'package:flutter/material.dart';
import '../models/reading_content.dart';
import '../services/storage_service.dart';
import '../services/tts_service.dart';
import '../core/constants.dart';

class ReadingProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final TtsService _ttsService = TtsService();
  
  ReadingContent _content = AppConstants.sampleContent;
  int _currentParagraphIndex = 0;
  bool _isPlaying = false;
  
  ReadingContent get content => _content;
  int get currentParagraphIndex => _currentParagraphIndex;
  bool get isPlaying => _isPlaying;

  ReadingProvider() {
    _init();
  }

  Future<void> _init() async {
    await _ttsService.init();
    _currentParagraphIndex = await _storageService.getBookmark();
    
    _ttsService.setCompletionHandler(() {
      _isPlaying = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> setParagraph(int index) async {
    if (index >= 0 && index < _content.paragraphs.length) {
      _currentParagraphIndex = index;
      if (_isPlaying) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> nextParagraph() async {
    if (_currentParagraphIndex < _content.paragraphs.length - 1) {
      _currentParagraphIndex++;
      if (_isPlaying) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> previousParagraph() async {
    if (_currentParagraphIndex > 0) {
      _currentParagraphIndex--;
      if (_isPlaying) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> play() async {
    _isPlaying = true;
    notifyListeners();
    await _ttsService.speak(_content.paragraphs[_currentParagraphIndex]);
  }

  Future<void> pause() async {
    _isPlaying = false;
    notifyListeners();
    await _ttsService.pause();
  }

  Future<void> stop() async {
    _isPlaying = false;
    notifyListeners();
    await _ttsService.stop();
  }

  Future<void> saveBookmark() async {
    await _storageService.saveBookmark(_currentParagraphIndex);
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}
