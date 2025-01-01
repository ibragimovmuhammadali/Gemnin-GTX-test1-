import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';  // Подключаем flutter_tts для TTS
import '../../data/models/message_model.dart';

final FlutterTts flutterTts = FlutterTts();  // Инициализируем экземпляр TTS

Widget itemOfGeminiMessage(MessageModel message) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30,
              child: Image.asset('assets/images/gemini_icon.png'),
            ),
            IconButton(
              onPressed: () {
                _speak(message.message ?? "No message to speak");// Вызов функции озвучивания
              },
              icon: const Icon(
                Icons.volume_up,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Text(
            message.message ?? "No message available", // Обработка null
            style: const TextStyle(
                color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

// Асинхронная функция для озвучивания текста
Future<void> _speak(String text) async {
  try {
    await flutterTts.setLanguage("en-US"); // Установка языка
    await flutterTts.setSpeechRate(0.65);  // Установка скорости речи
    await flutterTts.speak(text);// Воспроизведение текста
  } catch (e) {
    print("Error during TTS: $e");  // Логирование ошибок
  }
}
