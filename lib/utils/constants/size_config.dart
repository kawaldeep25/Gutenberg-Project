import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static bool? isStandardScreen;
  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth! < 500) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = screenWidth! / 100;
    _blockHeight = screenHeight! / 100;
    isStandardScreen = screenHeight! > 650 ? true : false;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    print('SizeConfig screenWidth is $screenWidth');
    print('SizeConfig screenHeight is $screenHeight');
    print('SizeConfig _blockHeight is $_blockHeight');
    print('SizeConfig _blockWidth is $_blockWidth');
  }
}
