import 'dart:convert';

import 'package:flutter/widgets.dart';

class AiQuestionModel {
  final String type;
  final String question;
  final List<String> options;
  final String answer;
  final String explanation;
  AiQuestionModel(
    this.type,
    this.question,
    this.options,
    this.answer,
    this.explanation,
  );

  factory AiQuestionModel.fromMap(Map<dynamic, dynamic> map) {
    debugPrint('传入的原始数据是: $map');
    final rawData = map['content'] == null ? map : map['content'][0] ?? map;

    debugPrint('传入的数据是: $rawData');
    final data = Map<String, dynamic>.from(rawData);
    return AiQuestionModel(
      data['type']?.toString() ?? '',
      data['question']?.toString() ?? '',
      (data['options'] as Iterable?)?.map((e) => e.toString()).toList() ?? [],
      data['answer']?.toString() ?? '',
      data['explanation']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'question': question,
      'options': options,
      'answer': answer,
      'explanation': explanation,
    };
  }
}
