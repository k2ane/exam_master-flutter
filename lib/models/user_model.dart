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
  final String status;
  final String token;
  LoginResponse({required this.status, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'token': token};
  }
}
