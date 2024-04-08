import 'package:flutter/material.dart';

extension UIThemeExtension on BuildContext {
  // * (default) TextTheme
  TextStyle? get bm => Theme.of(this).textTheme.bodyMedium;
}
