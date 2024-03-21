import 'package:flutter/material.dart';

class BlogEditorTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditorTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
      ),
      maxLines: null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "please enter $hintText";
        }
        return null;
      },
    );
  }
}
