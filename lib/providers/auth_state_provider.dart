import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = AsyncNotifierProvider<AuthState, bool>(() {
  return AuthState();
});

class AuthState extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final token = await ref.read(secureStorageProvider).getToken();
    return token != null && token.isNotEmpty;
  }

  // 登录成功
  Future<void> loginSuccess(String token) async {
    await ref.read(secureStorageProvider).setToken(token);
    state = const AsyncValue.data(true);
  }

  //退出登录
  Future<void> logout() async {
    await ref.read(secureStorageProvider).clearToken();
    state = const AsyncValue.data(false);
  }
}
