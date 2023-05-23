import 'package:flutter/material.dart';
import 'package:guten/utils/constants/size_config.dart';
import 'package:guten/utils/theme/app_colours.dart';
import 'package:guten/utils/theme/app_textstyles.dart';

class GutenbergTheme {
  static ThemeData appTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      splashColor: Colors.transparent,
      secondaryHeaderColor: Colors.black,
      appBarTheme: const AppBarTheme(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
          opacity: 1,
        ),
        color: AppColors.backgroundColor,
        elevation: 0,
      ),
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.backgroundColor,
      accentColor: AppColors.backgroundColor,
      errorColor: Colors.red[700],
      cursorColor: AppColors.primaryColor,
      textTheme: const TextTheme(
        headline1: AppTextStyles.h1, //H1
        headline2: AppTextStyles.h2, //H2H4
        bodyText1: AppTextStyles.body1, //body1
        bodyText2: AppTextStyles.body2, //body2
      ),
      cardTheme: CardTheme(
        // elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        shadowColor: const Color.fromRGBO(211, 209, 238, 0.5),
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0F0F6),
        focusColor: const Color(0xFF5E56E7),
        labelStyle: const TextStyle(
          color: Color(0xFFA0A0A0),
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat_Medium',
        ),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          gapPadding: 10.0,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            style: BorderStyle.solid,
            width: SizeConfig.isStandardScreen! ? 2 : 1.4,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        helperStyle: const TextStyle(
          color: AppColors.primaryColor,
        ),
        alignLabelWithHint: false,
        prefixStyle: const TextStyle(
          color: AppColors.grey,
        ),
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat_Medium',
        ),
        suffixStyle: const TextStyle(
          color: AppColors.grey,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      }),
      fontFamily: 'Montserrat',
      dividerColor: AppColors.grey,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: AppColors.blue).copyWith(
        background: AppColors.backgroundColor,
        primary: AppColors.primaryColor,
      ),
    );
  }
}
