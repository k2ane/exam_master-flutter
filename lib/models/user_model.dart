class LoginResponse {
  final String token;
  final String userId;
  // 根据后端返回实际字符端添加
  LoginResponse({required this.token, required this.userId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      // 根据实际后端字段修购
      token: json['token'] ?? '',
      userId: json['user']['id'] ?? '',
    );
  }
}

class RegisterResponse {
  final String token;
  final String userId;
  RegisterResponse({required this.token, required this.userId});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'] ?? '',
      userId: json['user']['id'] ?? '',
    );
  }
}
