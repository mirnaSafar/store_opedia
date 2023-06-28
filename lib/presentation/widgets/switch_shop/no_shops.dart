import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

import '../../shared/custom_widgets/custom_text.dart';

Widget buildNoShopItems(var size) {
  return Column(
    children: [
      SizedBox(
        height: size.height / 3,
      ),
      Center(
        child: Column(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: AppColors.mainBlueColor,
              size: 75,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomText(
              text: "You Don't Have another Shops !",
              bold: true,
              fontSize: 20,
            )
          ],
        ),
      ),
    ],
  );
}
