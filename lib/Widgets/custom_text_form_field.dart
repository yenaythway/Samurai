import 'package:flutter/material.dart';
import 'package:real_time_chatting/Utils/extension.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;
  final String? errorText;
  final Widget? error;
  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.errorText,
    this.error,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: context.bm,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          error: error,
          errorText: errorText,
          labelStyle: context.bm,
          errorStyle: context.bm!.copyWith(shadows: [
            const Shadow(
              color: Colors.black,
              offset: Offset(1, 0),
              blurRadius: 0.1,
            ),
          ], color: Colors.red),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
        validator: validator);
  }
}
