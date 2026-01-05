import 'package:exam_master_flutter/models/user_model.dart';
import 'package:exam_master_flutter/providers/http_cilent_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider((ref) {
  return LoginRepository(ref.watch(httpClientProvider));
});

class LoginRepository {
  final DioClient _client;
  LoginRepository(this._client);

  Future<LoginResponse> login(String email, String verificationCode) async {
    final sendData = {'email': email, 'passcode': verificationCode};
    final response = await _client.post('/auth/login', data: sendData);
    return LoginResponse.fromJson(response);
  }
}
