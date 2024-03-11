import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';

class AppTheme {
  static  _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  BorderSide(
        color: color,
        width: 1.5,
      ));
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border(AppPallete.borderColor),
        focusedBorder: _border(AppPallete.gradient3),
      ));
}
