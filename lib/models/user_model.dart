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

class CheckStatusResponse {
  final String status;
  final Map<String, dynamic> content;
  CheckStatusResponse({required this.status, required this.content});

  factory CheckStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckStatusResponse(
      status: json['status'] as String,
      content: json['content'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'content': content};
  }
}
