import 'package:flutter/material.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';

class AppTheme {
  static final darktheme = ThemeData.dark().copyWith(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppPallete.backgroundColor),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppPallete.borderColor)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppPallete.gradient2, width: 3),
              borderRadius: BorderRadius.circular(10))));
}
