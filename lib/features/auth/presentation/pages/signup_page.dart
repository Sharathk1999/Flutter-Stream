import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/features/auth/presentation/widgets/auth_gradient_btn.dart';

import '../widgets/auth_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AuthTextFormField(
              hintText: "Name",
            ),
            const SizedBox(
              height: 12,
            ),
            const AuthTextFormField(
              hintText: "Email",
            ),
            const SizedBox(
              height: 12,
            ),
            const AuthTextFormField(
              hintText: "Password",
            ),
            const SizedBox(
              height: 25,
            ),
            const AuthGradientBtn(),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Already have an account? ",
                  style: Theme.of(context).textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: "Sign In",
                      // ? - if titleSmall is null don't call copyWith
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppPallete.gradient2,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
