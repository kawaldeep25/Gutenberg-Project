import 'package:flutter/material.dart';
import 'package:guten/utils/theme/app_colours.dart';

class AppTextStyles {
//dhara text styling
  static const titles = TextStyle(
      fontSize: 28.0,
      height: 36 / 28,
      fontWeight: FontWeight.w700,
      fontFamily: 'Montserrat',
      color: AppColors.black);

  static const h1 = TextStyle(
    fontFamily: 'Montserrat_SemiBold',
    fontSize: 46,
  );
  static const h2 = TextStyle(
    fontFamily: 'Montserrat_SemiBold',
    fontSize: 30,
  );

  static const genreCard = TextStyle(
    fontFamily: 'Montserrat_Regular',
    fontSize: 20,
  );

  static const body1 = TextStyle(
    fontFamily: 'Montserrat_Regular',
    fontSize: 16,
  );

  static const searchBox = TextStyle(
    fontFamily: 'Montserrat_Regular',
    fontSize: 16,
  );

  static const bookName = TextStyle(
    fontFamily: 'Montserrat_Regular',
    fontSize: 12,
  );

  static const bookAuthor = TextStyle(
    fontFamily: 'Montserrat_Regular',
    fontSize: 12,
  );

  static const body2 = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Montserrat',
      color: AppColors.black,
      height: 22 / 18);

  static const double defaultMargin = 14;
}
