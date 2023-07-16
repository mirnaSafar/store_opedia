import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import 'package:shopesapp/logic/cubites/user/delete_user_cubit.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/auth_cubit.dart';
import '../../logic/cubites/mode/themes_cubit.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../widgets/dialogs/awosem_dialog.dart';
import '../widgets/settings/settings_til.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: size.height,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            children: [
              SettingsGroup(
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                  title: "Profile",
                  children: <Widget>[buildProfile(context)]),
              SizedBox(
                height: size.height * 0.01,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is UserLoginedIn) {
                    return SettingsGroup(
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary),
                        title: "Account",
                        children: <Widget>[buildSwitchUserAccount(context)]);
                  }
                  return SettingsGroup(
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.secondary),
                      title: "MY STORE",
                      children: <Widget>[
                        buildeAddNewSotre(context),
                        buildeEdeitMySotre(context, size),
                        buildSwitchSotre(context)
                      ]);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsGroup(
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                  title: "MODE",
                  children: <Widget>[buildLanguage(), buildThemes(context)]),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsGroup(
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                  title: "GENERAL",
                  children: <Widget>[
                    buildLogout(context),
                    BlocProvider<DeleteUserCubit>(
                      create: (context) => DeleteUserCubit(),
                      child: BlocConsumer<DeleteUserCubit, DeleteUserState>(
                        listener: (context, state) {
                          if (state is DeleteUserSucceed) {
                            BlocProvider.of<AuthCubit>(context).logOut();
                            context.read<ThemesCubit>().changeTheme(0);
                            context.pushRepalceme(const LoginPage());
                            CustomToast.showMessage(
                                context: context,
                                size: size,
                                message: "Delete Account Succecfuly",
                                messageType: MessageType.REJECTED);
                          } else if (state is DeleteUserFailed) {
                            buildAwsomeDialog(context, "Faild",
                                    state.message.toUpperCase(), "Cancle",
                                    type: DialogType.ERROR)
                                .show();
                          }
                        },
                        builder: (context, state) {
                          if (state is DeleteUserProgress) {
                            return const LinearProgressIndicator();
                          }
                          return buildDeleteAccount(
                            context,
                          );
                        },
                      ),
                    ),
                  ]),
              SizedBox(
                height: size.height * 0.01,
              ),
              SettingsGroup(
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                  title: "About",
                  children: <Widget>[
                    buildContactUs(context, size),
                    buildAbout(context)
                  ]),
              SettingsGroup(
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary),
                  title: "Privacy",
                  children: <Widget>[buildPrivacy(context)])
            ],
          ),
        ),
      ),
    );
  }
}
