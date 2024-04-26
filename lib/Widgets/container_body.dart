import 'package:flutter/material.dart';
import 'package:real_time_chatting/Constants/colors.dart';

class ContainerBody extends StatelessWidget {
  final Widget child;
  const ContainerBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: primaryColor,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: child,
      ),
    );
  }
}
