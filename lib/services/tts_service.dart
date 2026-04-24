import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  
  Future<void> init() async {
    await _flutterTts.setLanguage("tr-TR");
    await _flutterTts.setSpeechRate(0.4); // Biraz daha yavaş, öğrenci dostu
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  Future<void> pause() async {
    await _flutterTts.pause();
  }
  
  void setCompletionHandler(Function() handler) {
    _flutterTts.setCompletionHandler(handler);
  }
}
