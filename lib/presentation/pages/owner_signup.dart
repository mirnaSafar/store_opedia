import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/location_service.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/pages/map_page.dart';
import 'package:shopesapp/presentation/pages/signup_categories_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
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
class OwnerSignUp extends StatefulWidget {
  const OwnerSignUp({Key? key}) : super(key: key);

  @override
  State<OwnerSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<OwnerSignUp>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
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
  String? _email;
  TimeOfDay initTime = TimeOfDay.now().replacing(hour: 00, minute: 00);
  String? _password;
  String? _phoneNumber;
  String? _ownerName;
  String? storeLocation;
  String? storeStartWorkTime;
  String? storeEndWorkTime;
  String? storeCategory;

  @override
  void initState() {
    _email = globalSharedPreference.getString("email") ?? "";

    _phoneNumber = globalSharedPreference.getString("phoneNumber") ?? "";
    _ownerName = globalSharedPreference.getString("name") ?? "";
    super.initState();
  }

  void setOwnerName(String name) {
    _ownerName = name;
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

      BlocProvider.of<AuthCubit>(context).ownerSignUp(
        ownerName: _ownerName!,
        password: _password!,
        phoneNumber: _phoneNumber!,
        email: _email!,
        storeName: _storeNameController.text,
        storeCategory: storeCategoryController.text,
        storeLocation: storeLocationController.text,
        startWorkTime: storeStartWorkTimecontroller.text,
        endWorkTime: storeEndWorkTimeController.text,
        shopPhoneNumber: _storeNumberController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is OwnerSignedUp) {
          CustomToast.showMessage(
              context: context,
              size: size,
              message: "Sign UP Successfuly",
              messageType: MessageType.SUCCESS);
          context.pushRepalceme(const ControlPage());
        } else if (state is AuthFailed) {
          await buildAwsomeDialog(
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
                      Row(
                        children: [
                          Expanded(
                            child: UserInput(
                              text: 'Store Location',
                              controller: storeLocationController,
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              text: 'Store Location',
                              onPressed: () async {
                                // LocationService().getCurrentAddressInfo();
                                LocationData? currentLocation =
                                    await LocationService()
                                        .getUserCurrentLocation();
                                if (currentLocation != null) {
                                  context.push(MapView(
                                      currentLocation: currentLocation));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      UserInput(
                        text: 'Store Number',
                        controller: _storeNumberController,
                      ),
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
                                child: GestureDetector(
                                  onTap: () async {
                                    await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      setState(() {
                                        storeStartWorkTimecontroller.text =
                                            value!.format(context);
                                      });
                                    });
                                  },
                                  child: CustomText(
                                    text:
                                        storeStartWorkTimecontroller.text == ""
                                            ? initTime.format(context)
                                            : storeStartWorkTimecontroller.text,
                                  ),
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
                                child: GestureDetector(
                                  onTap: () async {
                                    await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      setState(() {
                                        storeEndWorkTimeController.text =
                                            value!.format(context);
                                      });
                                    });
                                  },
                                  child: CustomText(
                                    text: storeEndWorkTimeController.text == ""
                                        ? initTime.format(context)
                                        : storeEndWorkTimeController.text,
                                  ),
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
                                },
                                text: 'Signup',
                              );
                            },
                          )),
                    ]),
              )
            ])),
      )),
    );
  }
}
