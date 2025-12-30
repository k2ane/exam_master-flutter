import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpClient {
  // 1. 单例模式：保证全局只有一个 Dio 实例，节省资源
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;

  late Dio _dio;

  HttpClient._internal() {
    // 2. 基础配置
    BaseOptions options = BaseOptions(
      // ⚠️ 注意：安卓模拟器不能访问 localhost，要用 10.0.2.2
      // 如果你是真机调试，需要填你电脑的局域网 IP (如 192.168.1.5)
      baseUrl: 'http://10.0.2.2:3000/api/v1',

      connectTimeout: const Duration(seconds: 10), // 连接超时
      receiveTimeout: const Duration(seconds: 10), // 接收超时
    );

    _dio = Dio(options);

    // 3. 添加拦截器 (后面做登录 Token 自动添加就在这里)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("🚀 发送请求: ${options.path}");
          // 以后在这里加 Token: options.headers['Authorization'] = token;
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ 收到响应: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
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
