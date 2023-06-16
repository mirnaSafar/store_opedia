import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/pages/signup_categories_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/auth/confirm_form_field.dart';
import 'package:shopesapp/presentation/widgets/auth/phoneNumber_form_field.dart';
import '../../constant/clipper.dart';
import '../../logic/cubites/cubit/auth_state.dart';
import '../widgets/auth/email_form_field.dart';
import '../widgets/auth/password_form_field.dart';
import '../widgets/auth/user_name_form_field.dart';
import '../widgets/dialogs/awosem_dialog.dart';

// ignore: must_be_immutable
class OwnerSignUp extends StatefulWidget {
  const OwnerSignUp({Key? key}) : super(key: key);

  @override
  State<OwnerSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<OwnerSignUp>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  // TextEditingController _sms= TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _storeNumberController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  TextEditingController storeLocationController = TextEditingController();
  TextEditingController storeStartWorkTimecontroller = TextEditingController();
  TextEditingController storeEndWorkTimeController = TextEditingController();
  TextEditingController storeCategoryController = TextEditingController();
  var isPasswordHidden = true;
  var isConfiermPasswordHidden = true;
  late String _email;
  late String _sms;
  late String _password;
  late String _phoneNumber;
  late String _ownerName;
  late String _storeName;
  late String storeLocation;
  late String storeStartWorkTime;
  late String storeEndWorkTime;
  late String storeCategory;

  void setOwnerName(String name) {
    _ownerName = name;
  }

  void setSMS(String sms) {
    _sms = sms;
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
    return _password;
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      /* BlocProvider.of<UserAuthCubit>(context)
            .signin(_userName, _email, _password, _phoneNumber);
      */
      Navigator.pushNamed(context, '/control');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserSignedUp) {
          buildAwsomeDialog(context, "Succeed", "You Signin successfully", "OK",
                  type: DialogType.SUCCES)
              .show();
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
                      'Owner SignUp',
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreateEmailFormField(
                        setEmail: setEmail,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // CreateSMSFormField(setSMS: setSMS),
                      // const SizedBox(
                      //   height: 20.0,
                      // ),
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
                      CreateUserNameFormField(setUserName: setOwnerName),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CreatePhoneNumberFormField(
                          setPhoneNumber: setPhoneNumber),

                      UserInput(
                        text: 'Store Name',
                        controller: _storeNameController,
                      ),
                      UserInput(
                        text: 'Store Location',
                        controller: storeLocationController,
                      ),
                      // UserInput(
                      //   text: 'Store Number',
                      //   controller: _storeNumberController,
                      // ),
                      UserInput(
                          text: 'Store Category',
                          controller: storeCategoryController,
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  context.push(const SignUpCategoriesPage()),
                              icon: const Icon(Icons.comment))),
                      30.ph,
                      CustomText(
                        text: 'Store Work Time',
                        textColor: AppColors.secondaryFontColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 80,
                                child: UserInput(
                                  text: '7 am',
                                  controller: storeStartWorkTimecontroller,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CustomText(
                                text: 'to',
                                textColor: AppColors.secondaryFontColor,
                              ),
                            ),
                            SizedBox(
                                width: 80,
                                child: UserInput(
                                  text: '9 pm',
                                  controller: storeEndWorkTimeController,
                                )),
                          ],
                        ),
                      ),
                      30.ph,
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
                              return CustomButton(
                                onPressed: () {
                                  _submitForm(context);

                                  context.push(const ControlPage());
                                },
                                text: 'Signup',
                              );
                            },
                          )),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       'Didn\'t recive the SMS?',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w500, fontSize: 18),
                      //     ),
                      //     TextButton(
                      //       child: const Text(
                      //         'Request again',
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.w500, fontSize: 18),
                      //       ),
                      //       onPressed: () {},
                      //     )
                      //   ],
                      // ),
                    ]),
              )
            ])),
      )),
    );
  }
}
