import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../data/enums/message_type.dart';
import '../../data/models/user.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';
import '../shared/custom_widgets/custom_toast.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  late String _oldPassword;
  late User _user;
  @override
  void initState() {
    super.initState();
    // online
    /* _user = context.read<UserAuthCubit>().getUser();
    _oldPassword = _user.password;*/
    //offline
    _oldPassword = "123456789";
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
          /*  */
          /**/
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: PinCodeTextField(
              scrollPadding: const EdgeInsets.all(20),
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  fieldWidth: _oldPassword.length <= 10 ? 40.0 : 22.0,
                  fieldHeight: _oldPassword.length <= 10 ? 50.0 : 30.0),
              onCompleted: (value) {
                if (value != _oldPassword) {
                  CustomToast.showMessage(
                      size: size,
                      message: "Wrong Password",
                      messageType: MessageType.REJECTED);
                } else {
                  BlocProvider.of<ProfileCubit>(context).setVerifiy(true);
                  Navigator.pop(context);
                }
              },
              obscureText: true,
              obscuringCharacter: '*',
              textStyle:
                  TextStyle(fontSize: _oldPassword.length <= 10 ? 20 : 16),
              appContext: context,
              length: _oldPassword.length,
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: CustomText(
              text: "Verify   your   password   pleas",
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
            child: MaterialButton(
                elevation: 10.0,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.mainWhiteColor,
                  ),
                  CustomText(
                    text: "Cancel",
                    textColor: AppColors.mainWhiteColor,
                  )
                ]),
                onPressed: () {
                  Navigator.pop(context);
                  CustomToast.showMessage(
                      size: size,
                      message: "You Have to write the Password First !",
                      messageType: MessageType.INFO);
                }),
          )
        ],
      ),
    );
  }
}
