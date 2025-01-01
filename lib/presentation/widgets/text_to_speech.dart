import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

Future<void> _speak(String text) async {
  try {
    await flutterTts.setLanguage("en-US"); // Выберите язык: "ru-RU" для русского
    await flutterTts.setSpeechRate(0.5);   // Скорость речи
    await flutterTts.setVolume(1.0);       // Громкость
    await flutterTts.setPitch(1.0);        // Высота голоса
    await flutterTts.speak(text);

    // Лог для проверки
    print("Speaking: $text");
  } catch (e) {
    print("Error during TTS: $e");
  }
}
