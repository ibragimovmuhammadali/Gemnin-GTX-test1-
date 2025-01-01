// To parse this JSON data, do
//
//     final geminiTalkModel = geminiTalkModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/gemini_talk_entity.dart';



GeminiTalkModel geminiTalkModelFromJson(String str) => GeminiTalkModel.fromJson(json.decode(str));

String geminiTalkModelToJson(GeminiTalkModel data) => json.encode(data.toJson());

class GeminiTalkModel extends GeminiTalkEntity {

  GeminiTalkModel({
    required super.candidates,
    required super.usageMetadata,
    required super.modelVersion,
  });

  factory GeminiTalkModel.fromJson(Map<String, dynamic> json) => GeminiTalkModel(
    candidates: List<CandidateModel>.from(json["candidates"].map((x) => CandidateModel.fromJson(x))),
    usageMetadata: UsageMetadataModel.fromJson(json["usageMetadata"]),
    modelVersion: json["modelVersion"],
  );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
    "usageMetadata": usageMetadata.toJson(),
    "modelVersion": modelVersion,
  };
}

class CandidateModel extends CandidateEntity{

  CandidateModel({
    required super.content,
    required super.finishReason,
    required super.avgLogprobs,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
    content: ContentModel.fromJson(json["content"]),
    finishReason: json["finishReason"],
    avgLogprobs: json["avgLogprobs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "content": content.toJson(),
    "finishReason": finishReason,
    "avgLogprobs": avgLogprobs,
  };
}

class ContentModel extends ContentEntity{
  ContentModel({
    required super.parts,
    required super.role,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
    parts: List<PartModel>.from(json["parts"].map((x) => PartModel.fromJson(x))),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
    "role": role,
  };
}

class PartModel extends PartEntity{

  PartModel({
    required super.text,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) => PartModel(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class UsageMetadataModel extends UsageMetadataEntity{

  UsageMetadataModel({
    required super.promptTokenCount,
    required super.candidatesTokenCount,
    required super.totalTokenCount,
  });

  factory UsageMetadataModel.fromJson(Map<String, dynamic> json) => UsageMetadataModel(
    promptTokenCount: json["promptTokenCount"],
    candidatesTokenCount: json["candidatesTokenCount"],
    totalTokenCount: json["totalTokenCount"],
  );

  Map<String, dynamic> toJson() => {
    "promptTokenCount": promptTokenCount,
    "candidatesTokenCount": candidatesTokenCount,
    "totalTokenCount": totalTokenCount,
  };
}