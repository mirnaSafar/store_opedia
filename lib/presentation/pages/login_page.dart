import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/pages/privacy%20policies.dart';
import 'package:shopesapp/presentation/pages/start_sign_up_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/auth_cubit.dart';
import '../../logic/cubites/cubit/auth_state.dart';
import '../../logic/cubites/user_state.dart';
import '../widgets/auth/email_form_field.dart';
import '../widgets/auth/password_form_field.dart';
import '../widgets/dialogs/awosem_dialog.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isPasswordHidden = true;
  late String _email;
  late String _sms;
  late String _password;

  void setSMS(String sms) {
    _sms = sms;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //   BlocProvider.of<AuthCubit>(context).login(_email, _password);
      Navigator.pushReplacementNamed(context, '/control');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserLoginedIn || state is OwnerLoginedIn) {
          CustomToast.showMessage(
              size: size,
              message: 'Welcome again',
              messageType: MessageType.SUCCESS);
        } else if (state is AuthFailed) {
          buildAwsomeDialog(
                  context, "Faild", state.message.toUpperCase(), "Cancle",
                  type: DialogType.ERROR)
              .show();
        }
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainOrangeColor,
            body: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    // fit: StackFit.expand,
                    // alignment: Alignment.bottomCenter,
                    children: [
                      ClipPath(
                        clipper: firstClipper(),
                        child: ClipPath(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                            height: h / 1.3,
                            decoration: BoxDecoration(
                                color: AppColors.mainWhiteColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(right: 220, top: 70),
                                    child: Text(
                                      "Welcome",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    "By singing in you are agreeing with",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.secondaryFontColor),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  InkWell(
                                    child: Text(
                                      "Terms and privacy policy",
                                      style: TextStyle(
                                          color: AppColors.mainOrangeColor),
                                    ),
                                    onTap: () {
                                      context.push(const PrivacyPlicies());
                                    },
                                  ),
                                  const SizedBox(
                                    height: 70.0,
                                  ),
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
                                    height: 60.0,
                                  ),
                                  /*    Row(
                                    children: const [
                                      Text("do you have a store"),
                                      Icon(Icons.check_box)
                                    ],
                                  ),*/
                                  const SizedBox(
                                    height: 15.0,
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h / 5.5),
                        child: ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.mainWhiteColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            height: h,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(top: h / 1.6),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child:
                                              BlocBuilder<AuthCubit, AuthState>(
                                            builder: (context, state) {
                                              if (state is UserAuthProgress) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15),
                                                    backgroundColor: AppColors
                                                        .mainOrangeColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                onPressed: () =>
                                                    _submitForm(context),
                                                child: const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        40.px,
                                        Expanded(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                context.push(
                                                    const StartSignupPage());
                                              },
                                              child: Text(
                                                "Register",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .mainOrangeColor),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 15,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.mainWhiteColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  side: BorderSide(
                                                      color: AppColors
                                                          .mainOrangeColor))),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}

class firstClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();

    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.5642786, size.width,
        size.height * 0.7523714);
    path0.cubicTo(
        size.width * 1.0099500,
        size.height * 0.7744143,
        size.width * 0.9658250,
        size.height * 0.7850429,
        size.width * 0.9650000,
        size.height * 0.7857143);
    path0.quadraticBezierTo(
        size.width * 0.7237500, size.height * 0.8392857, 0, size.height);

    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.5700000);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(
        0, size.height * 0.8667786, 0, size.height * 0.8223714);
    path0.cubicTo(
        size.width * 0.0015500,
        size.height * 0.8087857,
        size.width * 0.0019750,
        size.height * 0.8030000,
        size.width * 0.0382750,
        size.height * 0.7863571);
    path0.quadraticBezierTo(size.width * 0.2787062, size.height * 0.7322679,
        size.width, size.height * 0.5700000);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
