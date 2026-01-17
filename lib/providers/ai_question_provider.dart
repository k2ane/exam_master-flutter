import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exam_master_flutter/models/ai_question_model.dart';
import 'package:exam_master_flutter/providers/http_cilent_provider.dart';
import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiQuestionProvider = Provider<AiQuestionProvider>((ref) {
  final http = ref.read(httpClientProvider);
  final storage = ref.read(secureStorageProvider);
  return AiQuestionProvider(http, storage);
});

class AiQuestionProvider {
  final DioClient _http;
  final SecureStorageProvider _storage;
  AiQuestionProvider(this._http, this._storage);

  Future<AiQuestionModel> getAiQuestions(int number, String topic) async {
    final token = await _storage.getToken();
    final sendToken = 'Bearer $token';
    final response = await _http.get(
      '/questions/generate',
      data: {'number': number, "topic": topic},
      options: Options(headers: {'Authorization': sendToken}),
    );
    debugPrint('getAiQuestions函数获取到的数据: $response');
    final je = jsonEncode(response);
    final jd = jsonDecode(je);
    return AiQuestionModel.fromMap(jd);
  }
}
