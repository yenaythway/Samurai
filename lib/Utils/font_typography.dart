import 'package:flutter/material.dart';

class FontTypography {
  static double getFontSizeByDevice(BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    fontSize = fontSize / 1.2;

    if (screenWidth >= 1280 && screenWidth < 1350) {
      double changedFontSize = fontSize + 3;

      return changedFontSize;
    } else if (screenWidth >= 1350 && screenWidth < 1880) {
      double changedFontSize = fontSize + 6;

      return changedFontSize;
    } else if (screenWidth >= 1880) {
      double changedFontSize = fontSize + 12;
      return changedFontSize;
    } else {
      return fontSize;
    }
  }
}
