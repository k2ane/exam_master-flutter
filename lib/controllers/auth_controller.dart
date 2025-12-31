import 'package:exam_master_flutter/models/user_model.dart';
import 'package:exam_master_flutter/providers/auth_provider.dart';
import 'package:exam_master_flutter/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<LoginResponse?> {
  final AuthRepository _repo;
  final AuthNotifier _notifier;
  // 构造函数
  AuthController(this._repo, this._notifier) : super(null);
  // 业务逻辑
  // 处理登录
  Future<void> login(String email, String password) async {
    try {
      // 获取用户信息
      final user = await _repo.login(email, password);
      // 将用户信息写入本地存储
      _notifier.login(user.token);
    } catch (e) {
      // 将错误抛出给View
      rethrow;
    }
  }

  Future<void> register(String email, String name, String passcode) async {
    try {
      // 获取用户信息
      final user = await _repo.register(email, name, passcode);
      // 将用户信息写入本地存储
      _notifier.login(user.token);
    } catch (e) {
      // 将错误抛出给View
      rethrow;
    }
  }
}
