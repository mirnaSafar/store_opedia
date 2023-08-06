/*import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../../data/enums/message_type.dart';
import '../../../logic/cubites/cubit/profile_cubit.dart';
import '../../../logic/cubites/user/update_user_cubit.dart';
import '../../pages/control_page.dart';
import '../../pages/porfile.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../dialogs/awosem_dialog.dart';
import '../dialogs/update_alert.dart';
import '../edit_profile/email_form_field.dart';
import '../edit_profile/password_form_field.dart';
import '../edit_profile/phoneNumber_form_field.dart';
import '../edit_profile/user_name_form_field.dart';

Widget buildUpdatePage({
  required BuildContext context,
  required Size size,
  required TextEditingController newUserName,
  required TextEditingController email,
  required TextEditingController newPassword,
  required TextEditingController newPhoneNumber,
  required TextEditingController oldPhoneNumber,
  required TextEditingController oldUserName,
  required var formKey,
}) {
  void submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showUpdateAlert(
        context: context,
        password: newPassword,
        phoneNumber: newPhoneNumber,
        userName: newUserName,
      );
    }
  }

  return Column(
    children: [
      EditUserNameFormField(userName: newUserName),
      (size.width * 0.1).ph,
      EditEmailFormField(email: email.text),
      (size.width * 0.1).ph,
      EditPasswordFormField(
          isPasswordHidden: isPasswordHidden, password: newPassword),
      (size.width * 0.1).ph,
      EditPhoneNumberFormField(phoneNmber: oldPhoneNumber),
      (size.width * 0.1).ph,
      BlocProvider<UpdateUserCubit>(
        create: (context) => UpdateUserCubit(),
        child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
          listener: (context, state) {
            if (state is UpdateUserSucceed) {
              CustomToast.showMessage(
                  context: context,
                  size: size,
                  message: "Updates User Info Successfully",
                  messageType: MessageType.SUCCESS);

              context.pushRepalceme(const ControlPage());
            } else if (state is UpdateUserFailed) {
              CustomToast.showMessage(
                  context: context,
                  size: size,
                  message: state.message,
                  messageType: MessageType.REJECTED);
            }
          },
          builder: (context, state) {
            if (state is UpdateUserProgress) {
              return const CircularProgressIndicator();
            }
            return Container(
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: MaterialButton(
                elevation: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Save Updates",
                      textColor: AppColors.mainWhiteColor,
                    )
                  ],
                ),
                onPressed: () {
                  if (((oldUserName.text == newUserName.text) &&
                          newPassword.text == "" &&
                          (newPhoneNumber.text == oldPhoneNumber.text)) ||
                      (newUserName.text.isEmpty &&
                          newPhoneNumber.text.isEmpty)) {
                    buildAwsomeDialog(context, "Field",
                            "You Already use the Same information", "OK",
                            type: DialogType.INFO)
                        .show();
                  } else {
                    submitForm(context);
                  }
                },
              ),
            );
          },
        ),
      ),
      (size.width * 0.1).ph,
      Container(
          width: 200.0,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
          child: MaterialButton(
            onPressed: () {
              BlocProvider.of<ProfileCubit>(context).setVerifiy(false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                CustomText(
                  text: "Show Profle Mode",
                  textColor: AppColors.mainWhiteColor,
                )
              ],
            ),
          ))
    ],
  );
}
*/