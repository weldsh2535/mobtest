class Users {
  String email;
  String password;
  Users({
    required this.email,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      email: (json['email'] != null) ? json["email"] : null,
      password: (json['password'] != null) ? json["password"] : null);
}
