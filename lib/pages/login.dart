import 'package:customer/bloc/auth/auth_bloc.dart';
import 'package:customer/bloc/auth/auth_event.dart';
import 'package:customer/bloc/auth/auth_state.dart';
import 'package:customer/core/app_colors.dart';
import 'package:customer/models/user_model.dart';
import 'package:customer/pages/home_screen.dart';
import 'package:customer/pages/widget/input_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late DateTime selectedDate;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthStateSucess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
      if(state is AuthStateFailure){
         showLoginErrorDialog(context);
      }
    }, builder: (context, state) {
      if (state is AuthStateLoading) {
        isLoading = true;
      } else {
        isLoading = false;
      }
      return Scaffold(
        backgroundColor: AppColors.white,
         bottomNavigationBar: const Padding(
          padding:  EdgeInsets.only(bottom:10.0),
          child: Text(
            "Tewos Technology 2024",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textColors),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
               SizedBox(height: MediaQuery.of(context).size.height *.05,),
                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * .6,
                          )
                        ],
                      ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(errorMessage),
                    
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0,bottom: 15),
                        child: Center(
                          child: Text(
                            "Welcome to ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      InputTextFormField(
                       // prefixText: "+251 ",
                        obscureText: false,
                        controller: phonenumberController,
                        keyboardType: TextInputType.emailAddress,
                        hintTxt: "Enter email",
                        autofillHints: const [AutofillHints.email],
                        validator: (value) {
                            if (value!.isEmpty) {
                                return "Please enter email";
                              }
                              // if (getStringLength(value) != 9) {
                              //   return "Phone number should be 9 characters";
                              // }
        
                              // if (!(value.startsWith('9') ||
                              //     value.startsWith('7'))) {
                              //   return "Phone number should start with 9 or 7";
                              // }
                              // if (!isNumeric(value)) {
                              //   return "Phone number should only contain numeric characters";
                              // }
                              return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      InputTextFormField(
                        obscureText: !showPassword,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        hintTxt: "Enter password",
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                          //if (value.length < 4) {
                          //return t(context).password_atleast6;
                          //}
                          //if (!_isNumeric(value)) {
                          //return t(context).phone_shouldnumeric;
                          //}
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                
                                    Users user = Users(
                                        email:
                                            phonenumberController.text.toString(),
                                        password: passwordController.text
                                            .toString());
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(LoginEvent(user: user));
                                 
                                }
                              }),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Forget password?",
                          style: TextStyle(
                              color: Color(0xffEC1276), fontSize: 13.0),
                        ),
                        onPressed: () {
                          // Navigator.pushReplacement(
                          // context,
                          // MaterialPageRoute(
                          // builder: (context) =>
                          // const ForgetPassword()),
                          // );
                        },
                      ),
                    
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ],
          ),
        ),
      );
    });
  }
void showLoginErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Center(
          child: Text(
            ("Login Error"),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 230, 8, 8)),
          ),
        ),
        content: const Text("Sorry,your Phone Number or Password is incorrect. please check and try again"),
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: const BorderSide(color: AppColors.borderColor),
              ), child: const Text("Ok"),
             ),
        ],
      );
    },
  );
}

}
