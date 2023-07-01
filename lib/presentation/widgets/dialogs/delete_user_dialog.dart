import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/user/delete_user_cubit.dart';

void showDeleteAlert(BuildContext context) {
  AwesomeDialog(
      btnOkColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      body: const Center(
        child: Text(
          'You Will Delete Your Account!',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        BlocProvider.of<DeleteUserCubit>(context).deleteUser();
      }).show();
}
