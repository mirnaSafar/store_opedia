import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/enums/message_color.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_text.dart';

Widget userMessage(var size, var message) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all((size.width * 0.05)),
        decoration: BoxDecoration(
            color: testMessageColor(message),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                (size.width * 0.08),
              ),
              topEnd: Radius.circular(
                (size.width * 0.08),
              ),
              topStart: Radius.circular(
                (size.width * 0.08),
              ),
            )),
        child: CustomText(
          text: message["description"],
          textColor: AppColors.mainWhiteColor,
        ),
      ),
    );

testMessageColor(message) {
  switch (message["type"]) {
    case "Error in pages":
      return messageColor[0];
    case "Suggestion":
      return messageColor[1];
    case "how to use":
      return messageColor[2];
    case "other":
      return messageColor[3];

    default:
      return messageColor[3];
  }
}
