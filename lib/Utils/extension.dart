import 'package:flutter/material.dart';

extension UIThemeExtension on BuildContext {
  TextStyle? get bl => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bm => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bs => Theme.of(this).textTheme.bodySmall;
}
