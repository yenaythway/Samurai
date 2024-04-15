import 'package:flutter/material.dart';

class GlobalUtil {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Future<void> showErrorDialog() => showDialog(
      context: navigatorKey.currentState!.context, builder: (_) => Container());
}
