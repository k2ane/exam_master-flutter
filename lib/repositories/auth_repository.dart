// 定义Provider
import 'package:exam_master_flutter/models/user_model.dart';
import 'package:exam_master_flutter/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthRepository(httpClient);
});

class AuthRepository {
  final HttpClient _client;
  AuthRepository(this._client);

  // 使用账号密码登录
  Future<LoginResponse> login(String email, String password) async {
    final response = await _client.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return LoginResponse.fromJson(response);
  }
}
