import 'package:flutter/material.dart';
import 'package:flutter_stream/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: 1.5,
      ));
  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll(AppPallete.backgroundColor),
        side: BorderSide.none,
      ),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        enabledBorder: _border(AppPallete.borderColor),
        focusedBorder: _border(AppPallete.gradient3),
        errorBorder: _border(AppPallete.errorColor),
      ));
}
