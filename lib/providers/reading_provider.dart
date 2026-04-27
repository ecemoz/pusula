import 'package:flutter/material.dart';
import '../models/reading_content.dart';
import '../services/storage_service.dart';
import '../services/tts_service.dart';
import '../core/constants.dart';

class ReadingProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final TtsService _ttsService = TtsService();

  List<ReadingContent> _library = [];
  ReadingContent _content = AppConstants.sampleContent;
  int _currentParagraphIndex = 0;
  bool _isPlaying = false;
  bool _playCurrentPage = false;

  List<ReadingContent> get library => List.unmodifiable(_library);
  ReadingContent get content => _content;
  int get currentParagraphIndex => _currentParagraphIndex;
  int get currentPageIndex =>
      _currentParagraphIndex ~/ AppConstants.pageChunkParagraphCount;
  int get pageCount =>
      (_content.paragraphs.length / AppConstants.pageChunkParagraphCount)
          .ceil();
  bool get isPlaying => _isPlaying;

  List<String> get pageChunks {
    final chunks = <String>[];
    for (
      int i = 0;
      i < _content.paragraphs.length;
      i += AppConstants.pageChunkParagraphCount
    ) {
      final end =
          (i + AppConstants.pageChunkParagraphCount <
              _content.paragraphs.length)
          ? i + AppConstants.pageChunkParagraphCount
          : _content.paragraphs.length;
      chunks.add(_content.paragraphs.sublist(i, end).join('\n\n'));
    }
    return chunks;
  }

  ReadingProvider() {
    _init();
  }

  Future<void> _init() async {
    await _ttsService.init();

    final savedLibrary = await _storageService.getLibraryContents();
    if (savedLibrary.isEmpty) {
      _library = [AppConstants.sampleContent];
      await _storageService.saveLibraryContents(_library);
    } else {
      _library = savedLibrary;
    }

    _content = _library.first;
    _currentParagraphIndex = await _storageService.getBookmarkForContent(
      _content.id,
    );
    _currentParagraphIndex = _currentParagraphIndex.clamp(
      0,
      _content.paragraphs.length - 1,
    );

    _ttsService.setCompletionHandler(() {
      _isPlaying = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> setParagraph(int index) async {
    if (index >= 0 && index < _content.paragraphs.length) {
      _currentParagraphIndex = index;
      if (_isPlaying && !_playCurrentPage) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> nextParagraph() async {
    if (_currentParagraphIndex < _content.paragraphs.length - 1) {
      _currentParagraphIndex++;
      if (_isPlaying && !_playCurrentPage) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> previousParagraph() async {
    if (_currentParagraphIndex > 0) {
      _currentParagraphIndex--;
      if (_isPlaying && !_playCurrentPage) {
        await play();
      }
      notifyListeners();
    }
  }

  Future<void> setPage(int pageIndex) async {
    if (pageIndex >= 0 && pageIndex < pageCount) {
      _currentParagraphIndex = pageIndex * AppConstants.pageChunkParagraphCount;
      if (_isPlaying && _playCurrentPage) {
        await playCurrentPage();
      }
      notifyListeners();
    }
  }

  Future<void> nextPage() async {
    if (currentPageIndex < pageCount - 1) {
      _currentParagraphIndex =
          (currentPageIndex + 1) * AppConstants.pageChunkParagraphCount;
      if (_isPlaying && _playCurrentPage) {
        await playCurrentPage();
      }
      notifyListeners();
    }
  }

  Future<void> previousPage() async {
    if (currentPageIndex > 0) {
      _currentParagraphIndex =
          (currentPageIndex - 1) * AppConstants.pageChunkParagraphCount;
      if (_isPlaying && _playCurrentPage) {
        await playCurrentPage();
      }
      notifyListeners();
    }
  }

  Future<void> setActiveContent(String contentId) async {
    final selected = _library.where((item) => item.id == contentId);
    if (selected.isEmpty) {
      return;
    }

    await stop();
    _content = selected.first;
    _currentParagraphIndex = await _storageService.getBookmarkForContent(
      _content.id,
    );
    _currentParagraphIndex = _currentParagraphIndex.clamp(
      0,
      _content.paragraphs.length - 1,
    );
    notifyListeners();
  }

  Future<ReadingContent> pullNewContent() async {
    final newContent = AppConstants.nextMockContent(_library);
    _library = [newContent, ..._library];
    _content = newContent;
    _currentParagraphIndex = 0;
    await _storageService.saveLibraryContents(_library);
    await saveBookmark();
    notifyListeners();
    return newContent;
  }

  Future<void> playCurrentPage() async {
    final index = currentPageIndex;
    if (index < 0 || index >= pageChunks.length) {
      return;
    }

    _playCurrentPage = true;
    _isPlaying = true;
    notifyListeners();
    await _ttsService.speak(pageChunks[index]);
  }

  Future<void> play() async {
    _playCurrentPage = false;
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
    _playCurrentPage = false;
    notifyListeners();
    await _ttsService.stop();
  }

  Future<void> saveBookmark() async {
    await _storageService.saveBookmark(_currentParagraphIndex);
    await _storageService.saveBookmarkForContent(
      _content.id,
      _currentParagraphIndex,
    );
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}
