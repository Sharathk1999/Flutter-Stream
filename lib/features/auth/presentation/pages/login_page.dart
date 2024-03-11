import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_stream/features/auth/presentation/widgets/auth_gradient_btn.dart';

import '../widgets/auth_text_form_field.dart';

class LoginPage extends StatefulWidget {
   static route()=> MaterialPageRoute(builder: (context) => const LoginPage(),);
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 12,
              ),
              AuthTextFormField(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(
                height: 12,
              ),
              AuthTextFormField(
                hintText: "Password",
                controller: passwordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 25,
              ),
              const AuthGradientBtn(
                btnName: "Login",
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        // ? - if titleSmall is null don't call copyWith
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
