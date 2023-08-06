import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/profile/password_form_field.dart';
import 'package:shopesapp/presentation/widgets/profile/phoneNumber_form_field.dart';

import '../../pages/verify_password.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text.dart';
import 'email_form_field.dart';

// ignore: unused_element
Widget buildUserInfoPage({
  required BuildContext context,
  required Size size,
  required String email,
  required String oldPhoneNumber,
  required String oldName,
}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          Center(
              child: CustomText(
            text: oldName,
            fontSize: 25,
          )),
          (size.width * 0.1).ph,
          ProfileEmailFormField(
            email: email,
          ),
          (size.width * 0.1).ph,
          const ProfilePasswordFormField(password: "123456789"),
          (size.width * 0.1).ph,
          ProfilePhoneNumberFormField(phoneNmber: oldPhoneNumber),
          (size.width * 0.1).ph,
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                onPressed: () {
                  context.pop();
                },
                text: 'cancel',
                color: AppColors.mainWhiteColor,
                textColor: Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.primary,
              )),
              (size.width * 0.08).px,
              Expanded(
                child: CustomButton(
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    context.push(const VerifyPassword());
                  },
                  text: 'Edit',
                  textColor: AppColors.mainWhiteColor,
                ),
              )
            ],
          ),
        ],
      ));
}
/* Container(
            width: 200.0,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10.0)),
            child: MaterialButton(
              elevation: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: "Edit",
                    textColor: AppColors.mainWhiteColor,
                  )
                ],
              ),
              onPressed: () {
                context.push(const VerifyPassword());
              },
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            child: MaterialButton(
              elevation: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: "Back",
                    textColor: AppColors.mainWhiteColor,
                  )
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),*/