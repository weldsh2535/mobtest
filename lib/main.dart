import 'package:customer/api_provider/customer_provider.dart';
import 'package:customer/api_provider/login_provider.dart';
import 'package:customer/bloc/auth/auth_bloc.dart';
import 'package:customer/bloc/customers/customer_bloc.dart';
import 'package:customer/pages/home_screen.dart';
import 'package:customer/pages/login.dart';
import 'package:customer/repositories/customer_repository.dart';
import 'package:customer/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   final LoginRepository loginRepository =
      LoginRepository(loginProvider: LoginProvider());
  final CustomerRepository customerRepository =
      CustomerRepository(customerProvider: CustomerProvider());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(loginRepository: loginRepository)),
              BlocProvider<CustomerBloc>(
              create: (context) => CustomerBloc(customerRepository: customerRepository)),
      ],
      child: MaterialApp(
        title: 'Customer List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
