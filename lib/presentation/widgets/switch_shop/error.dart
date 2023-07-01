import 'package:flutter/material.dart';

import '../../shared/custom_widgets/custom_text.dart';

Widget buildError(var size) {
  return Column(
    children: [
      SizedBox(
        height: size.height / 3,
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
              bold: true,
              fontSize: 25,
            )
          ],
        ),
      ),
    ],
  );
}
