

import 'package:customer/models/customer_model.dart';
import 'package:customer/models/user_model.dart';

abstract class CustomerState {}

class CustomerStateInital extends CustomerState {}
class CustomerStateLoading extends CustomerState {}
class CustomerStateSucess extends CustomerState {
   final List<User> data;
   CustomerStateSucess(this.data);
}


class CustomerStateErrorState extends CustomerState {
  final String error;

  CustomerStateErrorState(this.error);
}
