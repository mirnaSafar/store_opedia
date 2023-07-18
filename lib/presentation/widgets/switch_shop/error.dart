import 'package:flutter/material.dart';

import '../../shared/custom_widgets/custom_text.dart';

Widget buildError(var size) {
  return Column(
    children: [
      SizedBox(
        height: size.height / 5,
      ),
      Center(
        child: Column(
          children: [
            const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
              size: 75,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const CustomText(
              text: "Error",
              fontSize: 25,
            )
          ],
        ),
      ),
    ],
  );
}
