import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/themes.dart';
import '../../../logic/cubites/mode/themes_cubit.dart';

void showThemePicker(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select The Theme"),
          content: Row(
            children: [
              buildIconButton(context, 0),
              buildIconButton(context, 1),
              buildIconButton(context, 2)
            ],
          ),
        );
      });
}

Widget buildIconButton(BuildContext context, int index) => IconButton(
    onPressed: () {
      context.read<ThemesCubit>().changeTheme(index);

      Navigator.pop(context);
    },
    icon: Icon(
      Icons.circle_rounded,
      color: colorList[index],
    ));
