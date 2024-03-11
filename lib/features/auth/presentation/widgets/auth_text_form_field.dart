import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is filled!" ;
        }
        return null;
      },
    );
  }
}
