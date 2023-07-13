import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/verify_password_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/password_form_field.dart';

import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';
import '../shared/custom_widgets/custom_toast.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

String? _password;
void setPassword(String password) {
  _password = password;
}

String? getPassword() => _password;

class _VerifyPasswordState extends State<VerifyPassword> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/verified.png'),
            SizedBox(
              height: size.height / 400,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: EditPasswordFormField(
                  setPassword: setPassword,
                  isPasswordHidden: true,
                  password: ""),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: 200.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: BlocConsumer<VerifyPasswordCubit, VerifyPasswordState>(
                listener: (context, state) {
                  if (state is VerifyPasswordFailed) {
                    CustomToast.showMessage(
                        context: context,
                        size: size,
                        message: state.message,
                        messageType: MessageType.REJECTED);
                  } else if (state is VerifyPasswordSucceed) {
                    CustomToast.showMessage(
                        context: context,
                        size: size,
                        message: "Verify Password Succeed",
                        messageType: MessageType.SUCCESS);
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
                        context
                            .read<VerifyPasswordCubit>()
                            .verifyPassword(password: getPassword()!);
                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(color: AppColors.mainWhiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ));
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: 200.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    CustomToast.showMessage(
                        context: context,
                        size: size,
                        message: "You Have to write the Password First !",
                        messageType: MessageType.INFO);
                  },
                  child: Text(
                    "Cancle",
                    style: TextStyle(color: AppColors.mainWhiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
