import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/theme.dart';
import 'package:flutter_stream/features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Stream',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  } 
}


