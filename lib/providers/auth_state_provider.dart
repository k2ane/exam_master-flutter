import 'package:exam_master_flutter/providers/secure_storage_provider.dart';
import 'package:exam_master_flutter/providers/user_info_provider.dart';
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
  Future<void> loginSuccess(
    String token,
    String email,
    String id,
    String name,
  ) async {
    await ref.read(secureStorageProvider).setToken(token);
    await ref.read(secureStorageProvider).setUserEmail(email);
    await ref.read(secureStorageProvider).setUserId(id);
    await ref.read(secureStorageProvider).setUserName(name);
    ref.invalidate(userInfoProvider);
    state = const AsyncValue.data(true);
  }

  // 检查登录状态并刷新
  Future<void> checkLoginState(
    String token,
    String email,
    String id,
    String name,
  ) async {
    await ref.read(secureStorageProvider).setToken(token);
    await ref.read(secureStorageProvider).setUserEmail(email);
    await ref.read(secureStorageProvider).setUserId(id);
    await ref.read(secureStorageProvider).setUserName(name);
    ref.invalidate(userInfoProvider);
    state = const AsyncValue.data(true);
  }

  //退出登录
  Future<void> logout() async {
    await ref.read(secureStorageProvider).clearToken();
    await ref.read(secureStorageProvider).clearUserEmail();
    await ref.read(secureStorageProvider).clearUserId();
    await ref.read(secureStorageProvider).clearUserName();
    ref.invalidate(userInfoProvider);
    // await ref.read(secureStorageProvider).clearAll();
    state = const AsyncValue.data(false);
  }
}
