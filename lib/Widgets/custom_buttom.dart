import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.ontap, required this.text});
  final Function()? ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          width: double.infinity,
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
