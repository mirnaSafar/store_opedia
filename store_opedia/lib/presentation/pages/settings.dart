import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/constant/themes.dart';

import '../../logic/cubites/themes_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _colorIndex = 0;

  @override
  void initState() {
    _colorIndex = context.read<ThemesCubit>().getTheme();
    super.initState();
  }

  void _showThemePicker(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Select The Theme"),
            content: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _colorIndex = 0;
                      });
                      context.read<ThemesCubit>().changeTheme(_colorIndex);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.circle_rounded,
                      color: colorList[0],
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _colorIndex = 1;
                      });
                      context.read<ThemesCubit>().changeTheme(_colorIndex);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.circle_rounded,
                      color: colorList[1],
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _colorIndex = 2;
                      });
                      context.read<ThemesCubit>().changeTheme(_colorIndex);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.circle_rounded,
                      color: colorList[2],
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        ListTile(
            leading: Icon(
              Icons.color_lens,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Themes'),
            onTap: () {
              _showThemePicker(context);
            }),
        Container(
          height: 1,
          color: Colors.grey,
          width: double.infinity,
        ),
      ]),
    );
  }
}
