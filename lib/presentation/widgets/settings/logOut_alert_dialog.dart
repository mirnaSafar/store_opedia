import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/pages/login_page.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../../logic/cubites/cubit/auth_cubit.dart';
import '../../../logic/cubites/mode/themes_cubit.dart';

void showLogOutAlertDialog(BuildContext context) {
  AwesomeDialog(
      btnOkColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      body: const Center(
        child: Text(
          'You Will Log Out!',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        BlocProvider.of<AuthCubit>(context).logOut();
        context.read<ThemesCubit>().changeTheme(0);
        context.pushRepalceme(const LoginPage());
      }).show();
}
