import "dart:convert";

import "package:customer/core/constant.dart";
import "package:customer/models/login_response.dart";
import "package:customer/models/user_model.dart";
import "package:http/http.dart" as http;


class LoginProvider {
  Future<LoginResponse> login(Users user) async {
    try {
      final response = await http.post(Uri.parse("${AppUrls.newsAPIBaseURL}/login"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              {"email": user.email, "password": user.password}));
      if (response.statusCode == 201) {
        final value = LoginResponse.fromJson(jsonDecode(response.body));
        // setToken(value.token.toString());
        // setLoginResponse(value);
        // //print("the value aman firstname is ${value.user!.firstName}");
        return value;
      }
      // //print("the status code two is ${response.statusCode}");

      throw Exception(response.body);
    } catch (e) {
      // //print("the exception is  code one is $e");

      throw Exception(e.toString());
    }
  }
 }
