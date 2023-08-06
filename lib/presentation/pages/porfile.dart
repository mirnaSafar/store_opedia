import 'package:awesome_dialog/awesome_dialog.dart';
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
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        body: const Center(
          child: Text(
            'You Will Update Your Account Information !',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnCancelOnPress: () {},
        btnCancelText: 'Cancel',
        btnOkText: " Countinue",
        btnOkOnPress: () {
          BlocProvider.of<UpdateUserCubit>(context).updateUser(
              id: globalSharedPreference.getString("ID")!,
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
        BlocProvider<UpdateUserCubit>(
          create: (context) => UpdateUserCubit(),
          child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
            listener: (context, state) {
              if (state is UpdateUserSucceed) {
                CustomToast.showMessage(
                    context: context,
                    size: size,
                    message: "Updated User Info Successfully",
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
              return Container(
                width: 200.0,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0)),
                child: MaterialButton(
                  elevation: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: "Save Updates",
                        textColor: AppColors.mainWhiteColor,
                      )
                    ],
                  ),
                  onPressed: () {
                    if (((_oldName == getUserName()) &&
                            getPassword() == "" &&
                            (getPhoneNumber() == _oldPhoneNumber)) ||
                        (_newName!.isEmpty && _newPhoneNumber!.isEmpty)) {
                      buildAwsomeDialog(context, "Failrd",
                              "You Already use the Same information", "OK",
                              type: DialogType.INFO)
                          .show();
                    } else {
                      _submitForm(context);
                    }
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            child: MaterialButton(
              onPressed: () {
                BlocProvider.of<ProfileCubit>(context).setVerifiy(false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: "Show Profle Mode",
                    textColor: AppColors.mainWhiteColor,
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildUserInfoPage(BuildContext context, var pageWidth) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
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
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0)),
              child: MaterialButton(
                elevation: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Edit",
                      textColor: AppColors.mainWhiteColor,
                    )
                  ],
                ),
                onPressed: () {
                  context.push(const VerifyPassword());
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0)),
              child: MaterialButton(
                elevation: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "Back",
                      textColor: AppColors.mainWhiteColor,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
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
                    return _buildUserInfoPage(context, size.width);
                  },
                )
              ],
            )),
      ),
    );
  }
}
