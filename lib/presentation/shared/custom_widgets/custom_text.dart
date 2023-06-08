import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Color? textColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final bool? bold;
  final String text;

  const CustomText(
      {Key? key,
      this.textColor,
      this.fontSize,
      this.bold,
      required this.text,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          // height: 1.5,
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize ?? 16,
          color: textColor ?? Theme.of(context).primaryColorDark,
        ));
  }
}
