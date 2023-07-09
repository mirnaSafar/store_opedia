import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/auth/confirm_form_field.dart';
import 'package:shopesapp/presentation/widgets/auth/phoneNumber_form_field.dart';
import '../../constant/clipper.dart';
import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/auth_state.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../widgets/auth/email_form_field.dart';
import '../widgets/auth/password_form_field.dart';
import '../widgets/auth/user_name_form_field.dart';
import '../widgets/dialogs/awosem_dialog.dart';

// ignore: must_be_immutable
class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isPasswordHidden = true;
  var isConfiermPasswordHidden = true;
  String? _email;
  String? _password;
  String? _phoneNumber;
  String? _userName;

  void setUserName(String name) {
    _userName = name;
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getPassword() {
    return _password!;
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      BlocProvider.of<AuthCubit>(context)
          .userSignUp(_userName!, _email!, _password!, _phoneNumber!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserSignedUp) {
          CustomToast.showMessage(
              context: context,
              size: size,
              message: "Sign UP Successfuly",
              messageType: MessageType.SUCCESS);
          context.pushRepalceme(const ControlPage());
        } else if (state is AuthFailed) {
          buildAwsomeDialog(
                  context, "Faild", state.message.toUpperCase(), "Cancle",
                  type: DialogType.ERROR)
              .show();
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipPath(
                clipper: TsClip1(),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Text(
                      'User SignUp',
                      style: GoogleFonts.indieFlower(
                          textStyle: Theme.of(context).textTheme.headlineMedium,
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  CreateEmailFormField(
                    setEmail: setEmail,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CreatePasswordFormField(
                    isPasswordHidden: isPasswordHidden,
                    setPassword: setPassword,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CreateConfirmPasswordFormField(
                    getPassword: getPassword,
                    isConfiermPasswordHidden: isConfiermPasswordHidden,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CreateUserNameFormField(setUserName: setUserName),
                  const SizedBox(
                    height: 30.0,
                  ),
                  CreatePhoneNumberFormField(setPhoneNumber: setPhoneNumber),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () => _submitForm(context),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          );
                        },
                      )),
                  const SizedBox(
                    height: 15.0,
                  ),
                ]),
              )
            ])),
      )),
    );
  }
}
