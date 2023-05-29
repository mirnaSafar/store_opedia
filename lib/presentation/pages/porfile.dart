import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/repositories/delete_user_repository.dart';
import 'package:shopesapp/data/repositories/update_user_repository.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/email_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/password_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/phoneNumber_form_field.dart';
import 'package:shopesapp/presentation/widgets/edit_profile/user_name_form_field.dart';
import 'package:shopesapp/presentation/widgets/profile/appBar.dart';
import 'package:shopesapp/presentation/widgets/profile/password_form_field.dart';
import 'package:shopesapp/presentation/widgets/profile/phoneNumber_form_field.dart';
import '../../data/models/user.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';
import '../../logic/cubites/delete_user_cubit.dart';
import '../../logic/cubites/update_user_cubit.dart';
import '../../logic/cubites/user_cubit.dart';
import '../widgets/dialogs/alert_dialog.dart';
import '../widgets/dialogs/awosem_dialog.dart';
import '../widgets/profile/email_form_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isPasswordHidden = false;
late String _email;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
late String _id;

late String _oldPassword;
late String _oldPhoneNumber;
late User _user;
late String _oldUserName;
late String _newUserName;
late String _newPassword;
late String _newPhoneNumber;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    //online
    /* _user = context.read<UserAuthCubit>().getUser();
    _id = _user.id;
    _oldUserName = _user.userName;
    _oldPassword = _user.password;
    _oldPhoneNumber = _user.phoneNumber;
    _email = _user.email;*/

//offline
    _oldUserName = "test";
    _oldPassword = "123456789";
    _oldPhoneNumber = "0999999999";
    _email = "example@gmail.com";

    _newPassword = _oldPassword;
    _newPhoneNumber = _oldPhoneNumber;
    _newUserName = _oldUserName;
    super.initState();
  }

  void setUserName(String name) {
    _newUserName = name;
  }

  void setPhoneNumber(String phoneNumber) {
    _newPhoneNumber = phoneNumber;
  }

  void setPassword(String password) {
    _newPassword = password;
  }

  String getUserName() => _newUserName;

  String getPassword() => _newPassword;

  String getPhoneNumber() => _newPhoneNumber;

  void _showUpdateAlert(BuildContext context) {
    AwesomeDialog(
        btnOkColor: Colors.green,
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        body: const Center(
          child: Text(
            'You Will Update Your Account !',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnCancelOnPress: () {
          BlocProvider.of<ProfileCubit>(context).setVerifiy(false);
        },
        btnCancelText: 'Cancel',
        btnOkText: " Countinue",
        btnOkOnPress: () {
          BlocProvider.of<UpdateUserCubit>(context).updateUser(
              id: _id,
              userName: getUserName(),
              email: _email,
              password: getPassword(),
              phoneNumber: getPhoneNumber());
          print('After update' +
              _email +
              ' ' +
              _newPassword +
              " " +
              _newPhoneNumber +
              " " +
              _newUserName);
          BlocProvider.of<ProfileCubit>(context).setVerifiy(false);
        }).show();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showUpdateAlert(context);
    }
  }

  void _showDeleteAlert(BuildContext context) {
    AwesomeDialog(
        btnOkColor: Colors.green,
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        body: const Center(
          child: Text(
            'You Will Delete Your Account!',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnCancelOnPress: () {},
        btnCancelText: 'Cancel',
        btnOkText: " Countinue",
        btnOkOnPress: () {
          BlocProvider.of<DeleteUserCubit>(context).deleteUser(id: _id);
        }).show();
  }

  Widget _buildUpdatePage(BuildContext context) {
    return Column(
      children: [
        EditUserNameFormField(setUserName: setUserName, userName: _oldUserName),
        const SizedBox(
          height: 20.0,
        ),
        EditEmailFormField(email: _email),
        const SizedBox(
          height: 30.0,
        ),
        EditPasswordFormField(
            setPassword: setPassword,
            isPasswordHidden: isPasswordHidden,
            password: _oldPassword),
        const SizedBox(
          height: 30.0,
        ),
        EditPhoneNumberFormField(
            setPhoneNumber: setPhoneNumber, phoneNmber: _oldPhoneNumber),
        const SizedBox(
          height: 15.0,
        ),
        BlocProvider<UpdateUserCubit>(
          create: (context) => UpdateUserCubit(UpdateUserRepository()),
          child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
            listener: (context, state) {
              if (state is UpdateUserSucceed) {
                buildAwrsomeDialog(context, "Succeed",
                        "You Update your account successfully", "OK",
                        type: DialogType.SUCCES)
                    .show();

                Navigator.pushReplacementNamed(context, 'home');
              } else if (state is UpdateUserFailed) {
                buildAwrsomeDialog(
                        context, "Faild", state.message.toUpperCase(), "Cancle",
                        type: DialogType.ERROR)
                    .show();
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
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      Text(
                        "Save Updates",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (((_oldPassword == getPassword()) &&
                            (_oldUserName == getUserName()) &&
                            (getPhoneNumber() == _oldPhoneNumber)) ||
                        (_newPassword.isEmpty &&
                            _newUserName.isEmpty &&
                            _newPhoneNumber.isEmpty)) {
                      buildAwrsomeDialog(context, "Field",
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
          height: 5.0,
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
                children: const [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildUserInfoPage(BuildContext context, double pageWidth) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.05),
        child: Column(
          children: [
            Center(
              child: Text(
                _oldUserName,
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ProfileEmailFormField(
              email: _email,
            ),
            const SizedBox(
              height: 30.0,
            ),
            ProfilePasswordFormField(password: _oldPassword),
            const SizedBox(
              height: 30.0,
            ),
            ProfilePhoneNumberFormField(phoneNmber: _oldPhoneNumber),
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
                  children: const [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/verifiy");
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
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                onPressed: () => showDialogAlert(context),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            BlocProvider<DeleteUserCubit>(
              create: (context) => DeleteUserCubit(DeleteUserRepository()),
              child: BlocConsumer<DeleteUserCubit, DeleteUserState>(
                listener: (context, state) {
                  if (state is DeleteUserSucceed) {
                    buildAwrsomeDialog(context, "Succeed",
                            "You Delete your account successfully", "OK",
                            type: DialogType.SUCCES)
                        .show();
                    BlocProvider.of<UserAuthCubit>(context).logOut();
                  } else if (state is DeleteUserFailed) {
                    buildAwrsomeDialog(context, "Faild",
                            state.message.toUpperCase(), "Cancle",
                            type: DialogType.ERROR)
                        .show();
                  }
                },
                builder: (context, state) {
                  if (state is DeleteUserProgress) {
                    return const CircularProgressIndicator();
                  }
                  return Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: MaterialButton(
                        onPressed: () => _showDeleteAlert(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Text(
                              "Delete Account",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
                    return _buildUpdatePage(context);
                  }
                  return _buildUserInfoPage(context, pageWidth);
                },
              )
            ],
          )),
    );
  }
}
