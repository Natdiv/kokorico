import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: _getTextTheme(),
      backgroundColor: AppColors.backgroundColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primaryColorDark,
          showSelectedLabels: false,
          showUnselectedLabels: false),
      cardColor: AppColors.cardColor,
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0XFFA88D66),
          secondary: Color(0XFF2B601E),
          tertiary: Color(0xFFFBEFE3),
          background: Color(0xFFEEDBC6)),
    );
  }

  static TextTheme _getTextTheme() {
    return GoogleFonts.poppinsTextTheme();
  }
}
