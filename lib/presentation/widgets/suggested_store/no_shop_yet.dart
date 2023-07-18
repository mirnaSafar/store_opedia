import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

import '../../shared/custom_widgets/custom_text.dart';

Widget buildNoShopsYet(var size) {
  return Column(
    children: [
      SizedBox(
        height: size.height / 5,
      ),
      Center(
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.mainBlueColor,
              size: 75,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomText(
              text: "NO Shops Yet",
              fontSize: 25,
            )
          ],
        ),
      ),
    ],
  );
}
