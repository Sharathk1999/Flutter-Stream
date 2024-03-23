import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream/core/common/widgets/custom_loader.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';
import 'package:flutter_stream/core/utils/show_snackbar.dart';
import 'package:flutter_stream/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_stream/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_stream/features/auth/presentation/widgets/auth_gradient_btn.dart';
import 'package:flutter_stream/features/blog/presentation/pages/blog_page.dart';

import '../widgets/auth_text_form_field.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message, "Oops..!", ContentType.failure);
            }else if (state is AuthSuccess){
              Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
             if (state is AuthLoading) {
              return const LoaderWidget();
            }
            return Form(
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
                  AuthGradientBtn(
                    btnName: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
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
            );
          },
        ),
      ),
    );
  }
}
