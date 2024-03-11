import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_stream/features/auth/presentation/widgets/auth_gradient_btn.dart';

import '../widgets/auth_text_form_field.dart';

class SignUpPage extends StatefulWidget {
   static route()=> MaterialPageRoute(builder: (context) => const SignUpPage(),);
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
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
               AuthTextFormField(
                hintText: "Name",
                controller: nameController,
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
              const AuthGradientBtn(btnName: "Sign up",),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(
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
