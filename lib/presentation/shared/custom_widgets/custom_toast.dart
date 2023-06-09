import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

import '../colors.dart';

class CustomToast {
  static showMessage(
      {required Size size,
      required String message,
      MessageType? messageType = MessageType.INFO,
      required BuildContext context}) {
    String imageName = 'info';
    Color ShadowColor = AppColors.mainBlueColor;

    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        ShadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCESS:
        imageName = 'approved1-01';
        ShadowColor = Colors.greenAccent;
        break;
      case MessageType.INFO:
        imageName = 'info';
        ShadowColor = AppColors.mainBlueColor;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        ShadowColor = AppColors.mainOrangeColor;
        break;

      case null:
        break;
    }
    BotToast.showCustomText(
      toastBuilder: (value) {
        const Duration(seconds: 15);
        return Container(
            width: size.width * 0.75,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ShadowColor.withOpacity(0.5),
                    blurRadius: 7,
                    spreadRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size.width * 0.06,
                ),

                // SvgPicture.asset(
                //   'images/$imageName.svg',
                //   width: size.width * 0.3,
                //   height: size.width * 0.3,
                // ),
                // SizedBox(
                //   height: size.width * 0.06,
                // ),
                CustomText(
                  text: message,
                  textColor: Theme.of(context).primaryColorDark,
                ),
                SizedBox(
                  height: size.width * 0.06,
                ),
              ],
            ));
      },
    );
  }
}
