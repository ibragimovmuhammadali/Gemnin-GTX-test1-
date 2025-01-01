import 'package:flutter/material.dart'; // Импортируйте material.dart для SnackBar
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Импортируйте flutter_tts

class StarterController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final FlutterTts flutterTts = FlutterTts(); // Инициализация FlutterTts

  @override
  void onInit() {
    super.onInit();
    initVideoPlayer();
  }

  initVideoPlayer() {
    videoPlayerController = VideoPlayerController.asset("assets/videos/gemini_video.mp4");

    videoPlayerController.initialize().then((_) {
      update();
      videoPlayerController.play();
      videoPlayerController.setLooping(false); // Отключаем автоматическую цикличность видео
      _startPlaybackWithSync(); // Старт воспроизведения с синхронизацией текста
    }).catchError((error) {
      // Обработка ошибки
      print("Ошибка инициализации видео: $error");
      Get.snackbar(
        "Ошибка",
        "Не удалось инициализировать видео: $error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  Future<void> _startPlaybackWithSync() async {
    // Воспроизведение текста
    await _speak("Welcome to the gemini Can I help you");


    // Запуск видео с отслеживанием завершения
    videoPlayerController.addListener(() async {
      if (videoPlayerController.value.position >= videoPlayerController.value.duration) {
        // Если видео достигло конца, запускаем снова видео и текст
        await videoPlayerController.seekTo(Duration.zero);
        videoPlayerController.play();
        await _speak("Welcome to the gemini Can I help you");
      }
    });
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US"); // Установка языка
    await flutterTts.setSpeechRate(0.5); // Скорость речи
    await flutterTts.setVolume(1.0); // Громкость
    await flutterTts.speak(text); // Воспроизведение текста
  }
  exitVideoPlayer() {  videoPlayerController.dispose();
  flutterTts.stop(); // Остановить TTS, если он активен
   }

  @override
  void onClose() {
    videoPlayerController.dispose();
    flutterTts.stop(); // Остановить TTS
    super.onClose();
  }
}