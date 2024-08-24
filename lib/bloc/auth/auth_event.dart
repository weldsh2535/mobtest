


import 'package:customer/models/user_model.dart';

class AuthEvent {}
class LoginEvent extends AuthEvent {
  Users user;
  LoginEvent({required this.user});
}
