import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/presentation/pages/add_store_page.dart';
import 'package:shopesapp/presentation/pages/contact_us.dart';
import 'package:shopesapp/presentation/pages/login_page.dart';
import 'package:shopesapp/presentation/pages/porfile.dart';
import 'package:shopesapp/presentation/pages/privacy%20policies.dart';
import 'package:shopesapp/presentation/pages/start_sign_up_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/settings/theme.picker.dart';
import '../../../constant/enums.dart';
import '../../../main.dart';
import '../../pages/edit_store.dart';
import '../../pages/switch_store.dart';
import '../dialogs/browsing_alert_dialog.dart';
import '../dialogs/delete_user_dialog.dart';
import '../switch_shop/no_selected_store.dart';
import 'logOut_alert_dialog.dart';
import 'icon_widget.dart';

Widget buildProfile(BuildContext context) => SimpleSettingsTile(
      title: "My Account",
      leading: iconWidget(
          icon: Icons.person, color: const Color.fromARGB(255, 169, 141, 245)),
      onTap: () {
        if (SharedPreferencesRepository.getBrowsingPostsMode()) {
          showBrowsingDialogAlert(context);
        }
      },
      child: !SharedPreferencesRepository.getBrowsingPostsMode()
          ? const ProfilePage()
          : null,
    );

Widget buildLogout(BuildContext context) => SimpleSettingsTile(
      title: "LogOut",
      leading: iconWidget(icon: Icons.logout, color: Colors.grey),
      onTap: () {
        Settings.clearCache();
        showLogOutAlertDialog(context);
      },
    );
Widget buildLogin(BuildContext context) => SimpleSettingsTile(
      title: "Login",
      leading: iconWidget(icon: Icons.login, color: Colors.grey),
      child: const LoginPage(),
    );
Widget buildCreateAccount(BuildContext context) => SimpleSettingsTile(
      title: "Create Account",
      leading: iconWidget(
          icon: Icons.add_circle_outline_outlined,
          color: const Color.fromARGB(255, 52, 82, 134)),
      child: const StartSignupPage(),
    );

Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
      title: "Delete Account",
      leading: iconWidget(icon: Icons.delete, color: Colors.red),
      onTap: () => showDeleteAlert(context),
    );

Widget buildLanguage(BuildContext context) => SwitchSettingsTile(
      title: "Arabic Language",
      settingKey: KeyLanguage,
      leading: iconWidget(icon: Icons.translate, color: Colors.blueAccent),
      onChange: (value) async {
        value == true
            ? await context.setLocale(const Locale('ar'))
            : await context.setLocale(const Locale('en'));
      },
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
      title: "Edit store information",
      leading: iconWidget(icon: Icons.edit, color: Colors.orange),
      child: globalSharedPreference.getString("currentShop") == "noShop"
          ? noSelectedShop(size, context)
          : EditStore(),
    );
Widget buildSwitchSotre(BuildContext context) => SimpleSettingsTile(
      title: "Switch to another Store",
      leading:
          iconWidget(icon: Icons.compare_arrows_rounded, color: Colors.green),
      child: const SwitchStore(),
    );

Widget buildSwitchUserAccount(BuildContext context) => SimpleSettingsTile(
    title: "Add Store and Switch to Owner Account",
    leading: iconWidget(icon: Icons.add, color: Colors.green),
    onTap: () {
      if (SharedPreferencesRepository.getBrowsingPostsMode()) {
        showBrowsingDialogAlert(context);
      }
    },
    child: !SharedPreferencesRepository.getBrowsingPostsMode()
        ? const AddStorePage()
        : null);

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
        10.ph,
      ],
    );

Widget buildContactUs(BuildContext context, Size size) {
  return SimpleSettingsTile(
    title: "Contact Us",
    leading: iconWidget(icon: Icons.email, color: AppColors.mainOrangeColor),
    onTap: () {
      if (SharedPreferencesRepository.getBrowsingPostsMode()) {
        showBrowsingDialogAlert(context);
      }
    },
    child: !SharedPreferencesRepository.getBrowsingPostsMode()
        ? const ContactUs()
        : null,
  );
}
