import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 封装 HttpClientProvider
final httpClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioClient(dio);
});

final dioProvider = Provider<Dio>((ref) {
  // Dio配置
  final options = BaseOptions(
    baseUrl: 'http://localhost:3000/api/v1',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    contentType: Headers.jsonContentType,
  );
  // 实例化Dio
  final dio = Dio(options);
  // 添加拦截器
  dio.interceptors.add(
    LogInterceptor(
      // 仅在调试模式打印 body
      requestBody: kDebugMode,
      responseBody: kDebugMode,
    ),
  );
  // 返回实例
  return dio;
});

class ApiException implements Exception {
  final String message;
  final int? code;
  ApiException(this.message, {this.code});
  @override
  String toString() => message;
}

class DioClient {
  final Dio dio;
  DioClient(this.dio);
  // Get方法
  Future<dynamic> get(String path) async {
    try {
      final response = await dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  // post方法
  Future<dynamic> post(String path, {Object? data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  // 错误处理
  ApiException handleError(DioException e) {
    String errorDescription = '';
    switch (e.type) {
      case DioExceptionType.cancel:
        errorDescription = '请求已取消';
      case DioExceptionType.connectionTimeout:
        errorDescription = '连接超时，请检查网络';
      case DioExceptionType.receiveTimeout:
        errorDescription = '服务器响应超时';
      case DioExceptionType.sendTimeout:
        errorDescription = '发送超时，请检查网络';
      case DioExceptionType.badResponse:
        final stateCode = e.response?.statusCode;
        final errorData = e.response?.data;
        if (stateCode == 401) {
          return ApiException('未授权或登录过期', code: 401);
        }
        // 读取后端返回的错误信息
        if (errorData is Map && errorData['message'] != null) {
          errorDescription = errorData['message'];
        } else {
          errorDescription = '服务器错误 ($stateCode)';
        }
        break;
      case DioExceptionType.connectionError:
        errorDescription = '网络连接失败，请检查网络';
        break;
      default:
        errorDescription = '未知错误， 请重试';
    }
    return ApiException(errorDescription, code: e.response?.statusCode);
  }
}
