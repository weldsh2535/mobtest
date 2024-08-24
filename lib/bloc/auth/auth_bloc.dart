import 'package:customer/bloc/auth/auth_event.dart';
import 'package:customer/bloc/auth/auth_state.dart';
import 'package:customer/repositories/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginRepository loginRepository;
  AuthBloc({required this.loginRepository}) : super(AuthStateInital()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        try {
          emit(AuthStateLoading());
          final response = await loginRepository.login(event.user);
          if (response.token.isNotEmpty) {
            emit(AuthStateSucess());
          } else {
            emit(AuthStateFailure(message: "Failed to login"));
          }
        } catch (e) {
          emit(AuthStateFailure(message: "Failed to login"));
        }
      }

       
     
    });
  }
}
