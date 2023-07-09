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
  String? timeString;
  List<String>? timeParts;
  List<String>? timeDigetes;
  int? startTimeHour;
  int? startTimeMinute;
  int? endTimeHour;
  int? endTimeMinute;
  @override
  void initState() {
    timeString = globalSharedPreference.getString("startWorkTime");
    timeParts = timeString?.split(" ");
    timeDigetes = timeParts![0].split(":");
    startTimeHour = int.parse(timeDigetes![0]);
    startTimeMinute = int.parse(timeDigetes![1]);
    timeString = globalSharedPreference.getString("endWorkTime");
    timeParts = timeString?.split(" ");
    timeDigetes = timeParts![0].split(":");
    endTimeHour = int.parse(timeDigetes![0]);
    endTimeMinute = int.parse(timeDigetes![1]);

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
        globalSharedPreference.getString("startWorkTime")!;
    storeEndWorkTimeController.text =
        globalSharedPreference.getString("endWorkTime")!;

    super.initState();
  }

  final ImagePicker picker = ImagePicker();
  FileTypeModel? selectedFile;
  Future<FileTypeModel> pickFile(FileType type) async {
    String? path;
    switch (type) {
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? '');
        context.pop();

        setState(() {});
        break;
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? '');
        context.pop();

        setState(() {});

        break;
    }
    return FileTypeModel(path ?? '', type);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
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
              20.ph,
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    InkWell(
                        onTap: selectedFile == null
                            ? () {
                                pickImageDialg();
                                setState(() {});
                              }
                            : null,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: selectedFile != null
                              ? FileImage(File(selectedFile!.path))
                              : null,
                          child:
                              selectedFile == null || selectedFile!.path.isEmpty
                                  ? const Icon(Icons.image)
                                  : null,
                        )),
                    Visibility(
                      visible: selectedFile != null,
                      child: InkWell(
                        onTap: () {
                          pickImageDialg();
                          setState(() {});
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.mainOrangeColor,
                            child: const Icon(Icons.edit)),
                      ),
                    ),
                  ],
                ),
              ),
              20.ph,
              const CustomText(text: 'store profile'),
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
                                    initialTime: TimeOfDay(
                                        hour: startTimeHour!,
                                        minute: startTimeMinute!))
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
                        width: 80,
                        child: GestureDetector(
                          onTap: () async {
                            await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: endTimeHour!,
                                        minute: endTimeMinute!))
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
                  textColor: AppColors.mainOrangeColor,
                  borderColor: AppColors.mainOrangeColor,
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
                              message: "information  update Successfully",
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
                                        shopProfileImage: "noImage",
                                        shopCoverImage: "noImage",
                                        shopCategory:
                                            storeCategoryController.text,
                                        location: storeLocationController.text,
                                        closing:
                                            storeStartWorkTimecontroller.text,
                                        opening:
                                            storeEndWorkTimeController.text,
                                        shopPhoneNumber:
                                            storeNumberController.text)
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

  Future pickImageDialg() {
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
                      pickFile(FileType.CAMERA)
                          .then((value) => selectedFile = value);
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
                      pickFile(FileType.GALLERY)
                          .then((value) => selectedFile = value);
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
