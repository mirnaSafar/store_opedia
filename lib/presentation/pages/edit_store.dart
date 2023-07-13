import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/pages/signup_categories_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../data/enums/file_type.dart';
import '../../logic/cubites/shop/edit_shop_cubit.dart';
import '../shared/custom_widgets/custom_text.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../shared/utils.dart';
import '../shared/validation_functions.dart';

class EditStore extends StatefulWidget {
  const EditStore({Key? key}) : super(key: key);

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeNumberController = TextEditingController();
  TextEditingController storeCategoryController = TextEditingController();
  TextEditingController storeStartWorkTimecontroller = TextEditingController();
  TextEditingController storeEndWorkTimeController = TextEditingController();
  TextEditingController storeDescriptionController = TextEditingController();
  TextEditingController storeInstagramController = TextEditingController();
  TextEditingController storeFacebookController = TextEditingController();
  TextEditingController storeLocationController = TextEditingController();

  @override
  void initState() {
    storeNameController.text =
        globalSharedPreference.getString("shopName") ?? 'Store name';
    storeNumberController.text =
        globalSharedPreference.getString("shopPhoneNumber") ?? 'Store number';
    storeCategoryController.text =
        globalSharedPreference.getString("shopCategory") ?? "store Category ";
    storeDescriptionController.text =
        globalSharedPreference.getString("shopDescription") ??
            'Store description';
    storeLocationController.text =
        globalSharedPreference.getString("location") ?? "'store location'";
    storeStartWorkTimecontroller.text =
        globalSharedPreference.getString("startWorkTime") ?? "startWorkTime ";
    storeEndWorkTimeController.text =
        globalSharedPreference.getString("endWorkTime") ?? "endWorkTime ";
    profilePath = globalSharedPreference.getString("shopProfileImage") ?? '';
    coverPath = globalSharedPreference.getString("shopCoverImage") ?? '';

    super.initState();
  }

  final ImagePicker picker = ImagePicker();
  String? coverPath;
  String? profilePath;
  FileTypeModel? coverSelectedFile;
  FileTypeModel? profileSelectedFile;
  Future<FileTypeModel> pickFile(FileType type, bool profile) async {
    String? path;
    // coverSelectedFile?.path = coverPath!;
    // profileSelectedFile?.path = profilePath!;
    switch (type) {
      case FileType.GALLERY:
        await picker.pickImage(source: ImageSource.gallery).then((value) =>
            path = profile
                ? value?.path ?? profileSelectedFile?.path ?? profilePath ?? ''
                : value?.path ?? coverSelectedFile?.path ?? coverPath ?? '');
        context.pop();

        globalSharedPreference.setString(
            profile ? "shopProfileImage" : "shopCoverImage", path!);

        setState(() {});
        break;
      case FileType.CAMERA:
        await picker.pickImage(source: ImageSource.camera).then((value) =>
            path = profile
                ? value?.path ?? profileSelectedFile?.path ?? profilePath ?? ''
                : value?.path ?? coverSelectedFile?.path ?? coverPath ?? '');
        context.pop();
        globalSharedPreference.setString(
            profile ? "shopProfileImage" : "shopCoverImage", path!);

        setState(() {});

        break;
    }
    return FileTypeModel(path ?? '', type);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainWhiteColor,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: AppColors.mainWhiteColor,
        title: CustomText(
          text: 'Edit Store',
          fontSize: w * 0.05,
          // textColor: AppColors.mainWhiteColor,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              (w * 0.02).ph,
              Stack(
                // fit: StackFit.expand,
                // alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Wrap(
                    children: [
                      Container(
                          height: h / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.05),
                            color: AppColors.mainOrangeColor,
                          ),
                          width: w,
                          child: (coverSelectedFile != null) ||
                                  (coverSelectedFile == null &&
                                      coverPath != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                  child: Image.file(
                                    coverSelectedFile != null
                                        ? File(coverSelectedFile!.path)
                                        : File(coverPath!),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : const Icon(Icons.image)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: h / 4.5, start: w / 1.17),
                    child: InkWell(
                      onTap: () {
                        pickImageDialg(false);
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: w * 0.036,
                        backgroundColor: AppColors.mainWhiteColor,
                        child: CircleAvatar(
                            radius: w * 0.026,
                            backgroundColor: AppColors.mainBlueColor,
                            child: Icon(
                              Icons.edit,
                              size: w * 0.03,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: w * 0.35, start: w * 0.005),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: w * 0.12,
                          backgroundColor: AppColors.mainWhiteColor,
                          child: CircleAvatar(
                            radius: w * 0.11,
                            backgroundColor: AppColors.mainWhiteColor,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: w * 0.12,
                              backgroundImage: (profileSelectedFile != null) ||
                                      (profileSelectedFile == null &&
                                          profilePath != null)
                                  ? FileImage(profileSelectedFile != null
                                      ? File(profileSelectedFile!.path)
                                      : File(profilePath!))
                                  : null,
                              child: profileSelectedFile == null &&
                                      (profilePath == null)
                                  ? const Icon(Icons.store)
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: w * 0.17, start: w * 0.17),
                          child: InkWell(
                            onTap: () {
                              pickImageDialg(true);
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: w * 0.036,
                              backgroundColor: AppColors.mainWhiteColor,
                              child: CircleAvatar(
                                  radius: w * 0.026,
                                  backgroundColor: AppColors.mainBlueColor,
                                  child: Icon(
                                    Icons.edit,
                                    size: w * 0.03,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.ph,
              // const CustomText(text: 'store profile'),
              UserInput(
                  text: 'Store name',
                  controller: storeNameController,
                  validator: (name) => nameValidator(name, 'enter store name')
                  // return null;
                  ),
              UserInput(
                text: 'Store description',
                controller: storeDescriptionController,
              ),
              UserInput(
                  text: 'Store number',
                  controller: storeNumberController,
                  validator: (number) =>
                      numberValidator(number, 'enter store number')
                  // return null;
                  ),
              30.ph,
              CustomText(
                text: 'Store Work Time',
                textColor: AppColors.secondaryFontColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () async {
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
                            text: storeStartWorkTimecontroller.text,
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
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () async {
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
                            text: storeEndWorkTimeController.text,
                          ),
                        )),
                  ],
                ),
              ),
              UserInput(
                text: 'instagram account',
                controller: storeInstagramController,
              ),
              UserInput(
                text: 'facebook account',
                controller: storeFacebookController,
              ),
              UserInput(
                text: 'store location',
                controller: storeLocationController,
              ),
              30.ph,
              CustomButton(
                text: 'Change Store category',
                borderColor: AppColors.mainTextColor,
                textColor: AppColors.secondaryFontColor,
                color: const Color.fromRGBO(242, 242, 242, 1),
                onPressed: () {
                  context.push(const SignUpCategoriesPage());
                },
              ),
              30.ph,
              Row(children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () {
                    context.pop();
                  },
                  text: 'cancel',
                  color: AppColors.mainWhiteColor,
                  textColor: Theme.of(context).colorScheme.primary,
                  borderColor: Theme.of(context).colorScheme.primary,
                )),
                70.px,
                BlocProvider(
                  create: (context) => EditShopCubit(),
                  child: Expanded(
                    child: BlocConsumer<EditShopCubit, EditShopState>(
                      listener: (context, state) {
                        if (state is EditShopSucceed) {
                          CustomToast.showMessage(
                              context: context,
                              size: size,
                              message: "information updated Successfully",
                              messageType: MessageType.SUCCESS);
                        } else if (state is EditShopFailed) {
                          CustomToast.showMessage(
                              context: context,
                              size: size,
                              message: state.message,
                              messageType: MessageType.REJECTED);
                        }
                      },
                      builder: (context, state) {
                        if (state is EditShopProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return CustomButton(
                          text: 'Submit',
                          textColor: AppColors.mainWhiteColor,
                          onPressed: () {
                            !formKey.currentState!.validate()
                                ? CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: 'invalid information',
                                    messageType: MessageType.WARNING)
                                : {
                                    formKey.currentState!.save(),
                                    context.read<EditShopCubit>().editShop(
                                        shopName: storeNameController.text,
                                        shopDescription:
                                            storeDescriptionController.text,
                                        shopProfileImage:
                                            profileSelectedFile?.path ?? '',
                                        shopCoverImage:
                                            coverSelectedFile?.path ?? '',
                                        shopCategory:
                                            storeCategoryController.text,
                                        location: storeLocationController.text,
                                        closing:
                                            storeStartWorkTimecontroller.text,
                                        opening:
                                            storeEndWorkTimeController.text,
                                        shopPhoneNumber:
                                            storeNumberController.text),
                                    setState(() {})
                                  };
                          },
                        );
                      },
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    ));
  }

  Future pickImageDialg(bool profile) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      pickFile(FileType.CAMERA, profile).then((value) => profile
                          ? profileSelectedFile = value
                          : coverSelectedFile = value);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.mainOrangeColor,
                        ),
                        40.px,
                        const CustomText(
                          text: 'Camera',
                          fontSize: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      pickFile(FileType.GALLERY, profile).then((value) =>
                          profile
                              ? profileSelectedFile = value
                              : coverSelectedFile = value);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.mainOrangeColor,
                        ),
                        40.px,
                        const CustomText(
                          text: 'Gallery',
                          fontSize: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
