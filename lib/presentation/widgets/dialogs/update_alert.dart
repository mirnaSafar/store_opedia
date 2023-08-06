import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubites/user/update_user_cubit.dart';
import '../../../main.dart';

void showUpdateAlert({
  required BuildContext context,
  required TextEditingController userName,
  required TextEditingController password,
  required TextEditingController phoneNumber,
}) {
  AwesomeDialog(
      btnOkColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      body: const Center(
        child: Text(
          'You Will Update Your Account Information !',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        BlocProvider.of<UpdateUserCubit>(context).updateUser(
            id: globalSharedPreference.getString("ID")!,
            name: userName.text,
            password: password.text,
            phoneNumber: phoneNumber.text);
      }).show();
}
