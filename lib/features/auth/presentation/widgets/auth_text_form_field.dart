import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  const AuthTextFormField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
