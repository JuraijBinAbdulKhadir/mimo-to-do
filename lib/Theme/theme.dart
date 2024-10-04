import 'package:flutter/material.dart';
import 'package:todo_app/Theme/colors.dart';

class AppTheme{
  static final lightMode=ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.backGround,
    hintColor: Colors.grey,
      appBarTheme: AppBarTheme(backgroundColor: Colors.white)
  );
}