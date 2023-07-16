import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/data/enums/file_type.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/shared/fonts.dart';
import 'package:shopesapp/presentation/shared/utils.dart';

import '../../logic/cubites/post/update_post_cubit.dart';
import '../shared/validation_functions.dart';

class EditPostPage extends StatefulWidget {
  EditPostPage({Key? key, required this.post}) : super(key: key);
  Post post;
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
            .then((value) => path = value?.path ?? selectedFile?.path ?? '');

        context.pop();

        setState(() {});

        break;
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? selectedFile?.path ?? '');
        context.pop();
        setState(() {});

        break;
    }
    return FileTypeModel(path ?? '', type);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController updatePostPriceController = TextEditingController();
  TextEditingController updatePostNameController = TextEditingController();
  TextEditingController updatePostDescriptionController =
      TextEditingController();

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
        padding: EdgeInsets.symmetric(vertical: w * 0.06, horizontal: w * 0.06),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(children: [
            Center(
                child: CustomText(
              text: 'Edit Post',
              fontSize: AppFonts.primaryFontSize,
              textColor: AppColors.primaryFontColor,
            )),
            (w * 0.02).ph,
            const Center(child: CustomText(text: 'Edit your post details')),
            (w * 0.05).ph,
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
                        color: Colors.transparent,
                      ),
                      width: w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        child: selectedFile != null
                            ? Image.file(
                                File(selectedFile!.path),
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                widget.post.photos,
                                fit: BoxFit.contain,
                              ),
                      ),
                    )
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
            SizedBox(
              height: w * 0.03,
            ),
            UserInput(
              text: 'Product name',
              controller: updatePostNameController,
              validator: (name) => nameValidator(name, 'Enter product name'),
            ),
            UserInput(
              text: 'Product Description',
              controller: updatePostDescriptionController,
            ),
            UserInput(
              text: 'Product price',
              controller: updatePostPriceController,
            ),
            (w * 0.08).ph,
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
              (w * 0.1).px,
              Expanded(
                  child: BlocProvider(
                create: (context) => UpdatePostCubit(),
                child: BlocConsumer<UpdatePostCubit, UpdatePostState>(
                  listener: (context, state) async {
                    if (state is UpdatePostSucceed) {
                      CustomToast.showMessage(
                          size: size,
                          message: " Post edited Successfully",
                          messageType: MessageType.SUCCESS,
                          context: context);
                      // await context.read<PostsCubit>().getOwnerPosts(
                      //       ownerID: globalSharedPreference.getString("ID")!,
                      //       shopID: globalSharedPreference.getString("shopID")!,
                      //     );
                      context.pop();
                    } else if (state is UpdatePostFailed) {
                      CustomToast.showMessage(
                          size: size,
                          message: state.message,
                          messageType: MessageType.REJECTED,
                          context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatePostProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      onPressed: () {
                        !formKey.currentState!.validate()
                            ? CustomToast.showMessage(
                                size: size,
                                message: 'Please check required fields',
                                messageType: MessageType.WARNING,
                                context: context)
                            : {
                                formKey.currentState!.save(),
                                context.read<UpdatePostCubit>().updatePost(
                                      name: updatePostNameController.text,
                                      description:
                                          updatePostDescriptionController.text,
                                      photos: selectedFile?.path ?? '',
                                      category: globalSharedPreference
                                              .getString("shopCategory") ??
                                          '',
                                      price: updatePostPriceController.text,
                                      postID: widget.post.postID,
                                      shopID: widget.post.shopeID!,
                                    )
                              };
                      },
                      text: 'post',
                      textColor: AppColors.mainWhiteColor,
                    );
                  },
                ),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery.of(context).size.width * 0.08))),
      builder: (context) => Wrap(
        children: [
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            (MediaQuery.of(context).size.width * 0.08).px,
                            CustomText(
                              text: 'Camera',
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04),
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            (MediaQuery.of(context).size.width * 0.08).px,
                            CustomText(
                              text: 'Gallery',
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04),
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
