import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import 'package:shopesapp/logic/cubites/user/delete_user_cubit.dart';

import '../../shared/custom_widgets/custom_text.dart';

void showDeleteAlert(BuildContext context) {
  AwesomeDialog(
      btnOkColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is UserLoginedIn) {
              return const CustomText(
                text:
                    "You Will Delete Your Account , You Can't Restore Any Thing !",
                textAlign: TextAlign.justify,
                bold: true,
              );
            }
            return const CustomText(
              text:
                  "You Will Delete Your Account And All Sotres And Posts , You Can't Restore Any Thing !",
              bold: true,
              textAlign: TextAlign.justify,
            );
          },
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        BlocProvider.of<DeleteUserCubit>(context).deleteUser();
      }).show();
}
