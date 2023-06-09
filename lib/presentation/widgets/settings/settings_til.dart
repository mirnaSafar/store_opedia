import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shopesapp/presentation/pages/add_store_page.dart';
import 'package:shopesapp/presentation/pages/porfile.dart';
import 'package:shopesapp/presentation/pages/privacy%20policies.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/widgets/settings/theme.picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/enums.dart';
import '../../../data/enums/message_type.dart';
import '../../../main.dart';
import '../../pages/edit_store.dart';
import '../../pages/switch_store.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../dialogs/delete_user_dialog.dart';
import '../switch_shop/no_selected_store.dart';
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

Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
      title: "Delete Account",
      leading: iconWidget(icon: Icons.delete, color: Colors.red),
      onTap: () => showDeleteAlert(context),
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
      child: const PrivacyPlicies(),
    );

Widget buildeAddNewSotre(BuildContext context) => SimpleSettingsTile(
      title: "Add store",
      leading: iconWidget(icon: Icons.add, color: AppColors.mainRedColor),
      child: const AddStorePage(),
    );
Widget buildeEdeitMySotre(BuildContext context, var size) => SimpleSettingsTile(
      title: "Edit store informations",
      leading: iconWidget(icon: Icons.edit, color: Colors.orange),
      child: globalSharedPreference.getString("currentShop") == "notSelected"
          ? noSelectedShop(size, context)
          : const EditStore(),
    );
Widget buildSwitchSotre(BuildContext context) => SimpleSettingsTile(
      title: "Switch to another Store",
      leading:
          iconWidget(icon: Icons.compare_arrows_rounded, color: Colors.green),
      child: const SwitchStore(),
    );

Widget buildSwitchUserAccount(BuildContext context) => SimpleSettingsTile(
      title: "Add Stroe and Switch to Owner Account",
      leading: iconWidget(icon: Icons.add, color: Colors.green),
      child: const AddStorePage(),
    );

Widget buildAbout(BuildContext context) => ExpandableSettingsTile(
      title: "About",
      leading: iconWidget(
        icon: Icons.info_outline,
        color: AppColors.mainBlueColor,
      ),
      children: <Widget>[
        CustomText(
          text: "Version 0.1",
          textColor: Theme.of(context).primaryColorDark,
        ),
      ],
    );

Widget buildContactUs(BuildContext context, Size size) {
  return SimpleSettingsTile(
    title: "Contact Us",
    leading: iconWidget(icon: Icons.email, color: AppColors.mainOrangeColor),
    onTap: () async {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

      final Uri emailUrl = Uri(
          scheme: 'malito',
          path: "email.com",
          query: encodeQueryParameters(<String, String>{
            'subject': 'Store Opedia',
            'body': "Hello Admin "
          }));

      if (await canLaunchUrl(emailUrl)) {
        launchUrl(emailUrl);
      } else {
        CustomToast.showMessage(
            context: context,
            size: size,
            message: 'Please check the Internet Connection',
            messageType: MessageType.REJECTED);
      }
    },
  );
}
