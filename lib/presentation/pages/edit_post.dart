import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/data/enums/file_type.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/shared/utils.dart';

import '../shared/validation_functions.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({Key? key}) : super(key: key);

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainWhiteColor,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: const CustomText(text: 'edit product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(children: [
            Center(
                child: CustomText(
              text: 'Edit Post',
              fontSize: 28,
              textColor: AppColors.primaryFontColor,
            )),
            10.ph,
            const Center(child: CustomText(text: 'Edit your post details')),
            30.ph,
            Stack(
              // fit: StackFit.expand,
              // alignment: AlignmentDirectional.bottomEnd,
              children: [
                Wrap(
                  children: [
                    Container(
                        height: h / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.mainOrangeColor,
                        ),
                        width: w,
                        child: selectedFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  File(selectedFile!.path),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : const Icon(Icons.image)),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(top: h / 4.5, start: w / 1.28),
                  child: InkWell(
                    onTap: () {
                      pickImageDialg();
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.mainWhiteColor,
                      child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.mainBlueColor,
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            UserInput(
              text: 'Product name',
              validator: (name) => nameValidator(name, 'Enter product name'),
            ),
            UserInput(text: 'Product Description'),
            UserInput(text: 'Product price'),
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
              Expanded(
                  child: CustomButton(
                onPressed: () {
                  !formKey.currentState!.validate() || selectedFile == null
                      ? CustomToast.showMessage(
                          context: context,
                          size: size,
                          message: 'Please check required fields',
                          messageType: MessageType.REJECTED)
                      : Future.delayed(
                          const Duration(milliseconds: 1000),
                          () {
                            formKey.currentState!.save();
                            CustomToast.showMessage(
                                context: context,
                                size: size,
                                message: 'Edited Successfully',
                                messageType: MessageType.SUCCESS);
                          },
                        ).then((value) => context.pop());
                },
                text: 'Edit',
                textColor: AppColors.mainWhiteColor,
              )),
            ]),
          ]),
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
          Column(
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
        ],
      ),
    );
  }
}
