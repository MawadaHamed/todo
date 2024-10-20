import 'package:flutter/material.dart';

class AppTheme{
  static const Color primary = Color(0XFF5D9CEC);
  static const Color BackgroundLight = Color(0XFFDFECDB);
  static const Color BackgroundDark = Color(0XFF060E1E);
  static const Color black = Color(0XFF363636);
  static const Color white = Color(0XFFFFFFFF);
  static const Color gray = Color(0XFFC8C9CB);
  static const Color green = Color(0XFF61E757);
  static const Color red = Color(0XFFEC4B4B);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: BackgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: gray,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(
              width: 4,
              color: white
          ),
        ),
  ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: black
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: black
      )
    ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          shape: BeveledRectangleBorder(),
        )
      )
  );
  static ThemeData darkTheme = ThemeData();
}