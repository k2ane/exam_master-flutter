import 'package:dio/dio.dart';
import 'package:exam_master_flutter/models/user_model.dart';
import 'package:exam_master_flutter/providers/http_cilent_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.watch(httpClientProvider));
});

class AuthRepository {
  final DioClient _client;
  AuthRepository(this._client);

  Future<EmailResponse> sendEmailVerificationCode(String email) async {
    final sendData = {'email': email};
    final response = await _client.get('/auth/login', data: sendData);
    return EmailResponse.fromJson(response);
  }

  Future<LoginResponse> sigIn(String email, String passcode) async {
    final sendData = {'email': email, 'passcode': passcode};
    final response = await _client.post('/auth/login', data: sendData);
    return LoginResponse.fromJson(response);
  }

  Future<CheckStatusResponse> checkLoginState(String token) async {
    final String sendToken = 'Bearer $token';
    final response = await _client.get(
      '/user/status',
      options: Options(headers: {'Authorization': sendToken}),
    );
    return CheckStatusResponse.fromJson(response);
  }
}
