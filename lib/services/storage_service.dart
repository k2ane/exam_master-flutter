import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  // 单例模式
  static const _storage = FlutterSecureStorage();
  // key常量
  static const _tokenKey = 'auth_token';
  // 存储Token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // 读取Token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // 删除Token(退出登录时使用)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // 检查是否有Token
  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }
}
