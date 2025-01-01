import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/services/log_services.dart';
import '../../core/services/utils_service.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/gemini_talk_repository_impl.dart';
import '../../domain/usecases/gemini_text_and_image_usecase.dart';
import '../../domain/usecases/gemini_text_only_usecase.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  List<MessageModel> messages = [];
  String pickedImage64 = "";

  GeminiTextOnlyUseCase textOnlyUseCase = GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());
  GeminiTextAndImageUseCase textAndImageUseCase = GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  askToGemini() {
    String message = textController.text.toString().trim();
    if (message.isEmpty) {
      return;
    }

    if(pickedImage64.isNotEmpty){
      MessageModel mine = MessageModel(isMine: true, message: message, base64: pickedImage64);
      updateMessage(mine);
      apiTextAndImage(message, pickedImage64);
    }else{
      MessageModel mine = MessageModel(isMine: true, message: message);
      updateMessage(mine);
      apiTextOnly(message);
    }

    textController.clear();
    removePickedImage();
  }

  updateMessage(MessageModel messageModel) {
    messages.add(messageModel);
    isLoading = false;
    update();
    scrollToLast();
  }

  apiTextOnly(String text) async {
    isLoading = true;
    update();

    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.e(l);
      MessageModel messageModel = MessageModel(isMine: false, message: l);
      updateMessage(messageModel);
    }, (r) {
      LogService.i(r);
      MessageModel messageModel = MessageModel(isMine: false, message: r);
      updateMessage(messageModel);
    });
  }

  apiTextAndImage(String text, String base64Image)async{
    isLoading = true;
    update();

    var either = await textAndImageUseCase.call(text, base64Image);
    either.fold((l) {
      LogService.e(l);
      MessageModel messageModel = MessageModel(isMine: false, message: l);
      updateMessage(messageModel);
    }, (r) {
      LogService.i(r);
      MessageModel messageModel = MessageModel(isMine: false, message: r);
      updateMessage(messageModel);
    });
  }

  pickImageFromGallery() async{
    var result = await Utils.pickAndConvertImage();
    LogService.i(result);
    pickedImage64 = result;
    update();
  }

  removePickedImage(){
    pickedImage64 = "";
    update();
  }

  void scrollToLast() {
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.easeInOut,);
  }
}