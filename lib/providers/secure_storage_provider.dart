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
  static const String _userName = 'user_name'; // 用户显示名称
  static const String _userRole = 'user_role'; // 用户角色

  // 暴露方法给全局

  // 存储用户角色
  Future<void> setUserRole(String role) async {
    await _storage.write(key: _userRole, value: role);
  }

  //读取用户角色
  Future<String?> getUserRole() async {
    return await _storage.read(key: _userRole);
  }

  // 删除用户角色
  Future<void> clearUserRole() async {
    return await _storage.delete(key: _userRole);
  }

  // 存储用户显示名称
  Future<void> setUserName(String username) async {
    await _storage.write(key: _userName, value: username);
  }

  // 读取用户显示名称
  Future<String?> getUserName() async {
    return await _storage.read(key: _userName);
  }

  // 删除用户显示名称
  Future<void> clearUserName() async {
    await _storage.delete(key: _userName);
  }

  // 存储用户邮箱
  Future<void> setUserEmail(String email) async {
    await _storage.write(key: _userEmail, value: email);
  }

  // 读取用户邮箱
  Future<String?> getUserEmail() async {
    return await _storage.read(key: _userEmail);
  }

  // 删除用户邮箱
  Future<void> clearUserEmail() async {
    return await _storage.delete(key: _userEmail);
  }

  // 存储用户id
  Future<void> setUserId(String id) async {
    await _storage.write(key: _userId, value: id);
  }

  // 读取用户id
  Future<String?> getUserId() async {
    return await _storage.read(key: _userId);
  }

  // 删除用户id

  Future<void> clearUserId() async {
    return await _storage.delete(key: _userId);
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
