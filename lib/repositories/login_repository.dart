import 'package:customer/api_provider/login_provider.dart';
import 'package:customer/models/login_response.dart';
import 'package:customer/models/user_model.dart';

class LoginRepository {
  LoginProvider loginProvider;
  LoginRepository({required this.loginProvider});
  Future<LoginResponse> login(Users user) async {
    return loginProvider.login(user);
  }

}