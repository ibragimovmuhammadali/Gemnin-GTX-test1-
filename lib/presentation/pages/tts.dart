import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('IconButton Example')),
        body: Center(
          child: VolumeButton(textToSpeak: "Привет! Это тестовое сообщение."),
        ),
      ),
    );
  }
}

class VolumeButton extends StatefulWidget {
  final String textToSpeak;

  VolumeButton({required this.textToSpeak});

  @override
  _VolumeButtonState createState() => _VolumeButtonState();
}

class _VolumeButtonState extends State<VolumeButton> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future<void> _speak(String text) async {
    try {
      await flutterTts.setLanguage("en-US"); // Или "ru-RU"
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    } catch (e) {
      print("Error with TTS: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.volume_up,
        color: Colors.white70,
        size: 50.0,
      ),
      onPressed: () {
        _speak(widget.textToSpeak);
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}