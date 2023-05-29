import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class CustomIconTextRow extends StatelessWidget {
  const CustomIconTextRow({Key? key, required this.icon, required this.text})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
        ),
        20.px,
        CustomText(
          text: text,
          textColor: AppColors.mainTextColor,
        ),
      ],
    );
  }
}
