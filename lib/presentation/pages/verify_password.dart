import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopesapp/logic/cubites/cubit/verify_password_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';
import '../shared/custom_widgets/custom_toast.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  late int? _oldPasswordLength;
  @override
  void initState() {
    // context.read<VerifyPasswordCubit>().getOldPasswordLength();
    // _oldPasswordLength = context.read<VerifyPasswordCubit>().oldPasswordLength;
    _oldPasswordLength = 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/verified.png'),
          SizedBox(
            height: size.height / 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: PinCodeTextField(
              cursorColor: AppColors.mainBlackColor,
              scrollPadding: const EdgeInsets.all(20),
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  fieldWidth: _oldPasswordLength! <= 10 ? 40.0 : 22.0,
                  fieldHeight: _oldPasswordLength! <= 10 ? 50.0 : 30.0),
              onCompleted: (value) {
                /*   context
                    .read<VerifyPasswordCubit>()
                    .verifyPassword(password: value);*/
              },
              obscureText: true,
              obscuringCharacter: '*',
              textStyle:
                  TextStyle(fontSize: _oldPasswordLength! <= 10 ? 20 : 16),
              appContext: context,
              length: _oldPasswordLength!,
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: CustomText(
              text: "Verify   your   password   please",
              fontSize: 20.0,
              bold: true,
              textColor: Theme.of(context).primaryColorDark,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            child: BlocConsumer<VerifyPasswordCubit, VerifyPasswordState>(
              listener: (context, state) {
                if (state is VerifyPasswordFailed) {
                  CustomToast.showMessage(
                      size: size,
                      message: state.message,
                      messageType: MessageType.REJECTED);
                } else if (state is VerifyPasswordSucceed) {
                  CustomToast.showMessage(
                      size: size,
                      message: "Verify Password Succeed",
                      messageType: MessageType.REJECTED);
                  BlocProvider.of<ProfileCubit>(context).setVerifiy(true);
                  context.pop();
                }
              },
              builder: (context, state) {
                if (state is VerifyPasswordProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                    onPressed: () {
                      context.pop();
                      CustomToast.showMessage(
                          size: size,
                          message: "You Have to write the Password First !",
                          messageType: MessageType.INFO);
                    },
                    child: Text(
                      "Cancle",
                      style: TextStyle(color: AppColors.mainOrangeColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        backgroundColor: AppColors.mainWhiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(color: AppColors.mainOrangeColor)));
              },
            ),
          )
        ],
      ),
    );
  }
}
