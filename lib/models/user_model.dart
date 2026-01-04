class EmailResponse {
  final String status;
  final String message;
  EmailResponse({required this.status, required this.message});
  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}

class LoginResponse {
  final int statusCode;
  final String token;
  LoginResponse({required this.statusCode, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'] as int,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'statusCode': statusCode, 'toekn': token};
  }
}
