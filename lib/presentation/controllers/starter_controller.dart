import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StarterController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final FlutterTts flutterTts = FlutterTts();

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
      videoPlayerController.setLooping(false);
      _startPlaybackWithSync();
    }).catchError((error) {

      print("Error initializing video: $error");
      Get.snackbar("Error", "Failed to initialize video: $error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  Future<void> _startPlaybackWithSync() async {

    await _speak("Welcome to the gemini");



    videoPlayerController.addListener(() async {
      if (videoPlayerController.value.position >= videoPlayerController.value.duration) {

        await videoPlayerController.seekTo(Duration.zero);
        videoPlayerController.play();
        await _speak("Welcome to the gemini");
      }
    });
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }
  exitVideoPlayer() {  videoPlayerController.dispose();
  flutterTts.stop();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    flutterTts.stop();
    super.onClose();
  }
}