import 'package:flutter/material.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';

class AppTheme {
  static final light = ThemeData(
    backgroundColor: AppColors.background,
    fontFamily: 'Manrope',

    // AppBar
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.medium,
    ),

    //Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.grey_3,
      indent: 16,
      endIndent: 16,
      thickness: 1,
      space: 1,
    ),

    //BottomNavBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: AppTextStyles.regular.copyWith(
        fontSize: 10,
      ),
      unselectedLabelStyle: AppTextStyles.regular.copyWith(
        fontSize: 10,
      ),
    ),

    //text fields
    inputDecorationTheme: InputDecorationTheme(
        constraints: const BoxConstraints(maxHeight: 61.0),
        border: InputBorder.none,
        hintStyle: AppTextStyles.regular.copyWith(
          color: AppColors.grey_2,
        ),
        suffixIconColor: Colors.black),
  );
}
