class EmailResponse {
  final String status;
  final Map<String, dynamic> content;
  EmailResponse({required this.status, required this.content});
  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      status: json['status'] as String,
      content: json['content'] as Map<String, dynamic>,
    );
  }
  Map<String, dynamic> toJson() {
    return {'status': status, 'content': content};
  }
}

class LoginResponse {
  final String status;
  final Map<String, dynamic> content;
  LoginResponse({required this.status, required this.content});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as String,
      content: json['content'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'content': content};
  }
}
