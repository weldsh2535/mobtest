class LoginResponse {
  final String message;
  final String token;

  LoginResponse({required this.message, required this.token});

   factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      message: (json['message'] != null) ? json["message"] : null,
      token: (json['token'] != null) ? json["token"] : null);
}
