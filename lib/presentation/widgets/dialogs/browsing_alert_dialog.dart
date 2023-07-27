import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../shared/custom_widgets/custom_text.dart';

void showBrowsingDialogAlert(BuildContext context) {
  AwesomeDialog(
          btnOkColor: Colors.green,
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          body: const Center(
            child: CustomText(
              text:
                  'please Login ,or create a new account to be able to do this action',
              textAlign: TextAlign.center,
            ),
          ),
          btnCancelOnPress: () {},
          btnCancelText: 'Cancel',
          btnOkText: " Ok",
          btnOkOnPress: () {})
      .show();
}
