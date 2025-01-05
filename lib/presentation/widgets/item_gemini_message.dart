import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/models/message_model.dart';

final FlutterTts flutterTts = FlutterTts();

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
                _speak(message.message ?? "No message to speak");
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
            message.message ?? "No message available",
            style: const TextStyle(
                color: Color.fromRGBO(173, 173, 176, 1), fontSize: 16),
          ),
        ),
      ],
    ),
  );
}


Future<void> _speak(String text) async {
  try {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  } catch (e) {
    print("Error during TTS: $e");
  }
}
