import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/data/enums/file_type.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/posts_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/update_post_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/shared/fonts.dart';
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
                          color: AppColors.mainOrangeColor,
                        ),
                        width: w,
                        child: selectedFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(w * 0.05),
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
              validator: (name) => nameValidator(name, 'Enter product name'),
            ),
            UserInput(text: 'Product Description'),
            UserInput(text: 'Product price'),
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
                create: (context) => UpdatePostCubit(PostsRepository()),
                child: BlocConsumer<UpdatePostCubit, UpdatePostState>(
                  listener: (context, state) async {
                    if (state is UpdatePostSucceed) {
                      CustomToast.showMessage(
                          size: size,
                          message: " Post edited Successfully",
                          messageType: MessageType.SUCCESS);
                      await context.read<PostsCubit>().getPosts();
                    } else if (state is UpdatePostFailed) {
                      CustomToast.showMessage(
                          size: size,
                          message: state.message,
                          messageType: MessageType.REJECTED);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatePostProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      onPressed: () {
                        !formKey.currentState!.validate() &&
                                (selectedFile == null ||
                                    selectedFile!.path.isEmpty)
                            ? CustomToast.showMessage(
                                size: size,
                                message: 'Please check required fields',
                                messageType: MessageType.REJECTED)
                            : Future.delayed(
                                const Duration(milliseconds: 1000),
                                () {
                                  BotToast.showCustomLoading(
                                      toastBuilder: (context) {
                                    return SizedBox(
                                      width: w / 4,
                                      height: w / 4,
                                      child: SpinKitCircle(
                                        color: AppColors.mainOrangeColor,
                                        size: w / 8,
                                      ),
                                    );
                                  });
                                  formKey.currentState!.save();

                                  context.read<UpdatePostCubit>().updatePost(
                                      title: updatePostNameController.text,
                                      description:
                                          updatePostDescriptionController.text,
                                      postImages: selectedFile?.path ?? '',
                                      category: "",
                                      productPrice:
                                          updatePostPriceController.text,
                                      postID: '',
                                      shopID: '');
                                },
                              ).then((value) =>
                                {BotToast.closeAllLoading(), context.pop()});
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
