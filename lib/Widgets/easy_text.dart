// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:real_time_chatting/Utils/font_typography.dart';

// class EasyText extends StatelessWidget {
//   const EasyText(this.text,
//       {super.key,
//       this.textStyle = TextStyle(),
//       this.textAlign = TextAlign.center,
//       this.fontSize = 14,
//       this.fontWeight = FontWeight.w400,
//       this.color = Colors.black,
//       this.decoration = TextDecoration.none,
//       this.maxLine,
//       this.overflow = TextOverflow.ellipsis});
//   final String text;
//   final TextStyle textStyle;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Color color;
//   final TextDecoration decoration;
//   final TextOverflow overflow;
//   final int? maxLine;
//   final TextAlign textAlign;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       maxLines: maxLine,
//       style: TextStyle(
//           fontSize: FontTypography.getFontSizeByDevice(context, fontSize),
//           fontWeight: fontWeight,
//           color: color,
//           decoration: decoration,
//           overflow: overflow),
//     );
//   }
// }
