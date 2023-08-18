import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/user/update_user_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/pages/verify_password.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/email_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/password_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/phoneNumber_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/user_name_form_field.dart';
import 'package:shopesapp/presentation/widgets/profile/appBar.dart';
import 'package:shopesapp/presentation/widgets/profile/password_form_field.dart';
import 'package:shopesapp/presentation/widgets/profile/phoneNumber_form_field.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';
import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';
import '../shared/custom_widgets/custom_text.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../widgets/dialogs/awosem_dialog.dart';
import '../widgets/profile/email_form_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isPasswordHidden = false;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String? _email;
String? _oldPhoneNumber;
String? _oldName;
String? _newName;
String _newPassword = "";
String? _newPhoneNumber;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    _email = globalSharedPreference.getString("email");
    _oldName = globalSharedPreference.getString("name");
    _oldPhoneNumber = globalSharedPreference.getString("phoneNumber");
    _newPhoneNumber = _oldPhoneNumber;
    _newName = _oldName;

    super.initState();
  }

  void setUserName(String name) {
    _newName = name;
  }

  void setPhoneNumber(String phoneNumber) {
    _newPhoneNumber = phoneNumber;
  }

  void setPassword(String password) {
    _newPassword = password;
  }

  String getUserName() => _newName!;

  String getPassword() => _newPassword;

  String getPhoneNumber() => _newPhoneNumber!;

  void _showUpdateAlert(BuildContext context) {
    AwesomeDialog(
        btnOkColor: Colors.green,
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.warning,
        body: Center(
          child: Text(
            LocaleKeys.update_profile_alert.tr(),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnCancelOnPress: () {},
        btnCancelText: LocaleKeys.cancle.tr(),
        btnOkText: LocaleKeys.countinue.tr(),
        btnOkOnPress: () {
          BlocProvider.of<UpdateUserCubit>(context).updateUser(
              id: globalSharedPreference.getString("ID") ?? '0',
              name: getUserName(),
              password: getPassword(),
              phoneNumber: getPhoneNumber());
        }).show();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showUpdateAlert(context);
    }
  }

  Widget _buildUpdatePage(BuildContext context, Size size) {
    return Column(
      children: [
        EditUserNameFormField(setUserName: setUserName, userName: _oldName!),
        const SizedBox(
          height: 20.0,
        ),
        EditEmailFormField(email: _email!),
        const SizedBox(
          height: 30.0,
        ),
        EditPasswordFormField(
            setPassword: setPassword,
            isPasswordHidden: isPasswordHidden,
            password: _newPassword),
        const SizedBox(
          height: 30.0,
        ),
        EditPhoneNumberFormField(
            setPhoneNumber: setPhoneNumber, phoneNmber: _oldPhoneNumber!),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ProfileCubit>(context).setVerifiy(false);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      backgroundColor: AppColors.mainWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: Text(
                    LocaleKeys.show_profile_mode.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
            ),
            (size.width * 0.08).px,
            Expanded(
              child: BlocProvider<UpdateUserCubit>(
                create: (context) => UpdateUserCubit(),
                child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
                  listener: (context, state) {
                    if (state is UpdateUserSucceed) {
                      CustomToast.showMessage(
                          context: context,
                          size: size,
                          message: LocaleKeys.update_success.tr(),
                          messageType: MessageType.SUCCESS);

                      context.pushRepalceme(const ControlPage());
                    } else if (state is UpdateUserFailed) {
                      CustomToast.showMessage(
                          context: context,
                          size: size,
                          message: state.message,
                          messageType: MessageType.REJECTED);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateUserProgress) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                        onPressed: () {
                          if (((_oldName == getUserName()) &&
                                  getPassword() == "" &&
                                  (getPhoneNumber() == _oldPhoneNumber)) ||
                              (_newName!.isEmpty && _newPhoneNumber!.isEmpty)) {
                            buildAwsomeDialog(
                                    context,
                                    LocaleKeys.faild.tr(),
                                    LocaleKeys.same_info_alert.tr(),
                                    LocaleKeys.ok.tr(),
                                    type: DialogType.info)
                                .show();
                          } else {
                            _submitForm(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          LocaleKeys.edit.tr(),
                          style: TextStyle(color: AppColors.mainWhiteColor),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInfoPage(BuildContext context, Size size) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            Center(
                child: CustomText(
              text: _oldName!,
              fontSize: 25,
            )),
            const SizedBox(
              height: 20.0,
            ),
            ProfileEmailFormField(
              email: _email!,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const ProfilePasswordFormField(password: "123456789"),
            const SizedBox(
              height: 30.0,
            ),
            ProfilePhoneNumberFormField(phoneNmber: _oldPhoneNumber!),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          backgroundColor: AppColors.mainWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      child: Text(
                        LocaleKeys.back.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )),
                ),
                (size.width * 0.08).px,
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.push(const VerifyPassword());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        LocaleKeys.edit.tr(),
                        style: TextStyle(color: AppColors.mainWhiteColor),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildProfileAppBar(context),
                const SizedBox(
                  height: 10.0,
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is EditProfile) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.height * 0.05),
                          child: _buildUpdatePage(context, size));
                    }
                    return _buildUserInfoPage(context, size);
                  },
                )
              ],
            )),
      ),
    );
  }
}
/*
*/
