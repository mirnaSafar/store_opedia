import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shopesapp/presentation/pages/add_store_page.dart';
import 'package:shopesapp/presentation/pages/porfile.dart';
import 'package:shopesapp/presentation/pages/privacy%20policies.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/widgets/settings/theme.picker.dart';
import '../../../constant/enums.dart';
import '../../pages/edit_store.dart';
import '../../pages/switch_store.dart';
import '../dialogs/delete_user_dialog.dart';
import 'logOut_alert_dialog.dart';
import 'icon_widget.dart';

Widget buildProfile(BuildContext context) => SimpleSettingsTile(
      title: "My Account",
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade700,
        maxRadius: 25,
        child: CircleAvatar(
          maxRadius: 20,
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            Icons.person_rounded,
            size: 30,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      child: const ProfilePage(),
    );

Widget buildLogout(BuildContext context) => SimpleSettingsTile(
      title: "LogOut",
      leading: iconWidget(icon: Icons.logout, color: Colors.grey),
      onTap: () {
        Settings.clearCache();
        showLogOutAlertDialog(context);
      },
    );

Widget buildDeleteAccount(BuildContext context, String id) =>
    SimpleSettingsTile(
      title: "Delete Account",
      leading: iconWidget(icon: Icons.delete, color: Colors.red),
      onTap: () => showDeleteAlert(context, id),
    );

Widget buildLanguage() => SwitchSettingsTile(
      title: "Arabic Language",
      settingKey: KeyLanguage,
      leading: iconWidget(icon: Icons.translate, color: Colors.blueAccent),
    );

Widget buildThemes(BuildContext context) => SimpleSettingsTile(
      title: "Themes",
      leading: iconWidget(icon: Icons.color_lens, color: Colors.pink),
      onTap: () => showThemePicker(context),
    );

Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
      title: "Privacy & Policies",
      leading: iconWidget(icon: Icons.lock, color: Colors.amber),
      // onTap: () => Navigator.pushNamed(context, '/privacy&policies'),
      child: const PrivacyPlicies(),
    );

Widget buildeAddNewSotre(BuildContext context) => SimpleSettingsTile(
      title: "Add store",
      leading: iconWidget(icon: Icons.add, color: AppColors.mainRedColor),
      child: const AddStorePage(),
    );
Widget buildeEdeitMySotre(BuildContext context) => SimpleSettingsTile(
      title: "Edit store informations",
      leading: iconWidget(icon: Icons.edit, color: Colors.orange),
      child: const EditStore(),
    );
Widget buildSwitchSotre(BuildContext context) => SimpleSettingsTile(
      title: "Switch to another Store",
      leading:
          iconWidget(icon: Icons.compare_arrows_rounded, color: Colors.green),
      child: const SwitchStore(),
    );

Widget buildAbout() => ExpandableSettingsTile(
    title: "About",
    leading: iconWidget(
      icon: Icons.info_outline,
      color: Colors.indigo,
    ),
    children: const <Widget>[Text("Version 0.1")]);
