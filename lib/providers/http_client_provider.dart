import 'package:dio/dio.dart';
import 'package:exam_master_flutter/providers/auth_provider.dart';
import 'package:exam_master_flutter/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 定义 Provider 使用Riverpod管理HttpClient实例
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient(ref);
});

class HttpClient {
  // 持有 Ref对象
  final Ref _ref;
  late Dio _dio;
  // 接收Ref
  HttpClient(this._ref) {
    // 2. 基础配置
    BaseOptions options = BaseOptions(
      // ⚠️ 注意：安卓模拟器不能访问 localhost，要用 10.0.2.2
      // 如果你是真机调试，需要填你电脑的局域网 IP (如 192.168.1.5)
      baseUrl: 'http://10.0.2.2:3000/api/v1',
      // 设置接收和连接超时时间
      connectTimeout: const Duration(seconds: 10), // 连接超时
      receiveTimeout: const Duration(seconds: 10), // 接收超时
    );

    _dio = Dio(options);

    // 添加拦截器 (后面做登录 Token 自动添加就在这里)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 在请求发出前读取Token
          final storage = StorageService();
          final token = await storage.getToken();
          // 检查是否有token,如果有就加到Header中
          if (token != null) {
            // 后端使用node.js 需要再token前加上 "Bearer" 前缀
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint("🚀 发送请求: ${options.path}");
          // 继续发送请求
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ 收到响应: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 检测是否发生401错误(Token过期), 如果过期处理强制退出
          if (e.response?.statusCode == 401) {
            // 移除已失效的token强制退出登录
            _ref.read(authProvider.notifier).logout();
          }
          debugPrint("❌ 请求出错: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  // 4. 暴露 GET 方法
  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params);
      return response.data;
    } catch (e) {
      rethrow; // 把错误抛出去给 UI 层处理
    }
  }

  // 5. 暴露 POST 方法
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      Response response = await _dio.post(path, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
