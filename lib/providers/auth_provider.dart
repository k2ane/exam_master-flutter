import 'package:exam_master_flutter/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<bool> {
  final StorageService _storageService;
  AuthNotifier(this._storageService) : super(false) {
    _checkLoginStatus();
  } // 默认为未登录状态
  // 启动检查
  Future<void> _checkLoginStatus() async {
    final hasToken = await _storageService.hasToken();
    if (hasToken) {
      state = true;
    }
  }

  // 登录成功调用
  Future<void> login(String token) async {
    // 将获取的bearer token存入安全区
    await _storageService.saveToken(token);
    state = true;
  }

  // 退出登录调用
  Future<void> logout() async {
    await _storageService.deleteToken();
    state = false;
  }
}

// 暴露给全局
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(StorageService());
});
