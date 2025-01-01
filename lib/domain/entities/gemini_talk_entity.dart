// To parse this JSON data, do
//
//     final geminiTalkEntity = geminiTalkEntityFromJson(jsonString);

import 'dart:convert';

GeminiTalkEntity geminiTalkEntityFromJson(String str) => GeminiTalkEntity.fromJson(json.decode(str));

String geminiTalkEntityToJson(GeminiTalkEntity data) => json.encode(data.toJson());

class GeminiTalkEntity {
  List<CandidateEntity> candidates;
  UsageMetadataEntity usageMetadata;
  String modelVersion;

  GeminiTalkEntity({
    required this.candidates,
    required this.usageMetadata,
    required this.modelVersion,
  });

  factory GeminiTalkEntity.fromJson(Map<String, dynamic> json) => GeminiTalkEntity(
    candidates: List<CandidateEntity>.from(json["candidates"].map((x) => CandidateEntity.fromJson(x))),
    usageMetadata: UsageMetadataEntity.fromJson(json["usageMetadata"]),
    modelVersion: json["modelVersion"],
  );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
    "usageMetadata": usageMetadata.toJson(),
    "modelVersion": modelVersion,
  };
}

class CandidateEntity {
  ContentEntity content;
  String finishReason;
  double avgLogprobs;

  CandidateEntity({
    required this.content,
    required this.finishReason,
    required this.avgLogprobs,
  });

  factory CandidateEntity.fromJson(Map<String, dynamic> json) => CandidateEntity(
    content: ContentEntity.fromJson(json["content"]),
    finishReason: json["finishReason"],
    avgLogprobs: json["avgLogprobs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "content": content.toJson(),
    "finishReason": finishReason,
    "avgLogprobs": avgLogprobs,
  };
}

class ContentEntity {
  List<PartEntity> parts;
  String role;

  ContentEntity({
    required this.parts,
    required this.role,
  });

  factory ContentEntity.fromJson(Map<String, dynamic> json) => ContentEntity(
    parts: List<PartEntity>.from(json["parts"].map((x) => PartEntity.fromJson(x))),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
    "role": role,
  };
}

class PartEntity {
  String text;

  PartEntity({
    required this.text,
  });

  factory PartEntity.fromJson(Map<String, dynamic> json) => PartEntity(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class UsageMetadataEntity {
  int promptTokenCount;
  int candidatesTokenCount;
  int totalTokenCount;

  UsageMetadataEntity({
    required this.promptTokenCount,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
  });

  factory UsageMetadataEntity.fromJson(Map<String, dynamic> json) => UsageMetadataEntity(
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