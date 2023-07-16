import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class CustomSortRow extends StatelessWidget {
  const CustomSortRow({Key? key, required this.title, this.subtitle, this.icon})
      : super(key: key);
  final String title;
  final String? subtitle;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.sp,
        children: [
          // 20.px,
          Icon(icon),
          20.px,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                bold: true,
              ),
              if (subtitle != null) ...[8.ph, CustomText(text: subtitle ?? '')]
            ],
          ),
        ],
      ),
    );
  }
}
