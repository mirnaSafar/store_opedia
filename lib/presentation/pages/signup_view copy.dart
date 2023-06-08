import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:sizer/sizer.dart';

import '../shared/colors.dart';
import '../shared/custom_widgets/custom_text.dart';
import '../shared/fonts.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  // final FilePickerResult? result = FilePicker.platform.pickFiles();
  File? file;
  XFile? choosedImage;

  Widget pickImageDialog() {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () async {
                choosedImage =
                    await picker.pickImage(source: ImageSource.camera);
                setState(() {
                  if (choosedImage != null) file = null;
                });
              },
              child: const CustomText(text: 'camera')),
          30.ph,
          InkWell(
              onTap: () async {
                choosedImage =
                    await picker.pickImage(source: ImageSource.gallery);

                setState(() {
                  if (choosedImage != null) file = null;
                });
              },
              child: const CustomText(text: 'gallery')),
          30.ph,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainWhiteColor,
      body: Sizer(
        builder: (context, orientation, deviceType) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                40.ph,
                Center(
                    child: CustomText(
                        text: 'Sign Up',
                        fontSize: AppFonts.primaryFontSize,
                        textColor: AppColors.primaryFontColor)),
                10.ph,
                const Center(
                    child: CustomText(text: 'Add your details to sign up')),
                30.ph,
                Align(
                  alignment: Alignment.center,
                  child: Stack(children: [
                    InkWell(
                      onTap: choosedImage == null && file == null
                          ? () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return pickImageDialog();
                                  });
                              // setState(() {});
                            }
                          : null,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: choosedImage != null && file == null
                              ? FileImage(
                                  File(choosedImage!.path),
                                )
                              : null,
                          child: file != null && choosedImage == null
                              ? const Icon(Icons.file_copy_sharp)
                              : choosedImage == null
                                  ? const Icon(Icons.image)
                                  : null),
                    ),
                    Positioned(
                      top: 70,
                      left: 65,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return pickImageDialog();
                              });
                        },
                        child: Visibility(
                          visible: choosedImage != null || file != null,
                          child: const CircleAvatar(
                            radius: 16,
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
