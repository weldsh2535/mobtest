import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;
  final String? hintTxt;
  final IconButton? suffixIcon;
  final String? prefixText;
  final FocusNode? focusNode;
  final List<String>? autofillHints;
  const InputTextFormField(
      {super.key,
      required this.obscureText,
      required this.controller,
      required this.keyboardType,
      required this.validator,
      this.hintTxt,
      this.suffixIcon,
      this.prefixText,
      this.focusNode,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 2),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        autofillHints: autofillHints,
        decoration: InputDecoration(
          prefixText: prefixText != null ? prefixText! : '',
          fillColor: Colors.white12,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: hintTxt,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                color:Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const  BorderSide(
                color:Colors.black),
          ),
          suffixIcon: suffixIcon,
        ),
        validator: (value) => validator(value.toString()),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
