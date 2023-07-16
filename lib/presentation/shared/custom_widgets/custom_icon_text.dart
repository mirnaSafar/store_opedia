import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class CustomIconTextRow extends StatelessWidget {
  const CustomIconTextRow(
      {Key? key,
      required this.icon,
      required this.text,
      this.iconColor,
      this.textColor,
      this.fontSize})
      : super(key: key);
  final String icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/$icon.svg',
          // color: iconColor ?? Colors.grey[600],
          width: 25,
          height: 25,
        ),
        // Icon(
        //   icon,
        //   color: iconColor ?? Colors.grey[600],
        // ),
        20.px,
        CustomText(
          text: text,
          fontSize: fontSize ?? 15,
          textColor: textColor ?? AppColors.mainBlackColor,
        ),
      ],
    );
  }
}
