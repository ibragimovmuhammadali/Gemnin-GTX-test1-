import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


import '../controllers/home_controller.dart';
import '../widgets/item_gemini_message.dart';
import '../widgets/item_user_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controller = Get.find<HomeController>();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // Инициализация для SpeechToText
  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'),
      onError: (error) => print('Speech error: $error'),
    );
    if (!available) {
      print("Speech recognition is not available.");
    }
  }

  // Функция для начала записи
  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
            _controller.textController.text = _text; // Устанавливаем распознанный текст в TextField
          });
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
      }
    }
  }

  // Функция для остановки записи
  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<HomeController>(
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                  child: Image(
                    image: AssetImage('assets/images/gemini_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: _controller.messages.isNotEmpty
                              ? ListView.builder(
                            controller: _controller.scrollController,
                            itemCount: _controller.messages.length,
                            itemBuilder: (context, index) {
                              var message = _controller.messages[index];
                              if (message.isMine!) {
                                return itemOfUserMessage(message);
                              } else {
                                return itemOfGeminiMessage(message);
                              }
                            },
                          ) : Center(child: SizedBox(height: 80, width: 80, child: Image.asset('assets/images/gemini_icon.png'),),),
                        ),
                        _controller.isLoading ? Center(child: Container(
                          width: 40,
                          height: 40,
                          child: Lottie.asset("assets/lotties/lottie.json"),
                        ),) : SizedBox.shrink(),
                      ],)),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.pickedImage64.isNotEmpty ? Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                base64Decode(_controller.pickedImage64),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  _controller.removePickedImage();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) : SizedBox.shrink(),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller.textController,
                              maxLines: null,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _controller.pickImageFromGallery();
                            },
                            icon: Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _controller.askToGemini();
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: _isListening ? _stopListening : _startListening,
                            icon: Icon(
                              _isListening ? Icons.stop : Icons.mic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}