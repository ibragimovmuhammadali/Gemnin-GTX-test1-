
import 'package:dartz/dartz.dart';

abstract class GeminiTalkRepository{

  Future<Either<String, String>> onTextOnly(String text);

  Future<Either<String, String>> onTextAndImage(String text, String base64Image);
}