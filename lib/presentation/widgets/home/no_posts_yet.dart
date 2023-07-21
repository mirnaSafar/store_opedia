import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

import '../../shared/custom_widgets/custom_text.dart';

Widget buildNoPostsYet(var size, var text) {
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
            CustomText(
              text: text,
              fontSize: 20,
            )
          ],
        ),
      ),
    ],
  );
}
