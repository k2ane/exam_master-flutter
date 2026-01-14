import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageProvider>((ref) {
  return SecureStorageProvider();
});

class SecureStorageProvider {
  // 实例化对象
  late final FlutterSecureStorage _storage;
  SecureStorageProvider() {
    _storage = FlutterSecureStorage(aOptions: AndroidOptions());
  }

  static const String _tokenKey = 'auth_token'; // 用户token
  static const String _userEmail = 'user_email'; // 用户邮箱
  static const String _userId = "user_id"; // 用户id

  // 暴露方法给全局

  // 存储用户邮箱
  Future<void> setUserEmail(String email) async {
    await _storage.write(key: _userEmail, value: email);
  }

  // 存储用户id
  Future<void> setUserId(String id) async {
    await _storage.write(key: _userId, value: id);
  }

  // 存储token
  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // 读取token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // 删除token
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // 清空所有残留数据
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
