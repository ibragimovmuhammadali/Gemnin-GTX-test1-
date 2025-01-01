import 'package:dartz/dartz.dart';

import '../repositories/gemini_talk_repository.dart';


class GeminiTextAndImageUseCase {
  final GeminiTalkRepository repository;

  GeminiTextAndImageUseCase(this.repository);

  Future<Either<String, String>> call(String text, String base64Image) async {
    return await repository.onTextAndImage(text, base64Image);
  }
}