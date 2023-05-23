import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppAssets {
  static const splashLogo = "assets/images/splash_logo.png";

  static const adventure = 'assets/images/adventure.svg';
  static const back = 'assets/images/back.svg';
  static const cancel = 'assets/images/cancel.svg';
  static const drama = 'assets/images/drama.svg';
  static const fiction = 'assets/images/fiction.svg';
  static const history = 'assets/images/history.svg';
  static const humour = 'assets/images/humour.svg';
  static const next = 'assets/images/next.svg';
  static const pattern = 'assets/images/pattern.svg';
  static const philosophy = 'assets/images/philosophy.svg';
  static const politics = 'assets/images/politics.svg';
  static const search = 'assets/images/search.svg';
}

Widget getSvgIcon(
    {required String iconName, Color? color, double? width, double? height}) {
  return SvgPicture.asset(
    iconName,
    width: width,
    height: height,
  );
}

Widget getSvgIconNetwork(
    {required String iconName, Color? color, double? width, double? height}) {
  return SvgPicture.network(
    iconName,
    width: width,
    height: height,
  );
}
