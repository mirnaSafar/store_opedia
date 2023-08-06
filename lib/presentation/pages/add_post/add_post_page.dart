import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopesapp/data/enums/file_type.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/logic/cubites/post/add_post_cubit.dart';
import 'package:shopesapp/logic/cubites/post/posts_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/shared/utils.dart';
import '../../shared/validation_functions.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final ImagePicker picker = ImagePicker();
  // late Shop shop;
  TextEditingController addPostPriceController = TextEditingController();
  TextEditingController addPostNameController = TextEditingController();
  TextEditingController addPostDescriptionController = TextEditingController();
  // late String? addPostImage;
  FileTypeModel? selectedFile;
  File? imageFile;
  String? postImageType;
  String? splitImagePath;
  String? imageBase64;
  void getImagePath() {}
  Future<FileTypeModel> pickFile(FileType type) async {
    String? path;
    switch (type) {
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? selectedFile?.path ?? '');
        imageFile = File(path!);
        splitImagePath = path!.split("/").last;
        postImageType = splitImagePath!.split(".").last;
        imageBase64 = base64Encode(imageFile!.readAsBytesSync());

        context.pop();

        break;
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? selectedFile?.path ?? '');
        context.pop();
        setState(() {
          imageFile = File(path!);
          splitImagePath = path!.split("/").last;
          postImageType = splitImagePath!.split(".").last;
          imageBase64 = base64Encode(imageFile!.readAsBytesSync());
        });

        break;
    }
    return FileTypeModel(path ?? '', type);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: w * 0.06, horizontal: w * 0.06),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(children: [
            Center(
                child: CustomText(
              text: 'Add Post',
              fontSize: w * 0.07,
              textColor: AppColors.primaryFontColor,
            )),
            (w * 0.04).ph,
            const Center(child: CustomText(text: 'Add your post details')),
            (w * 0.06).ph,
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
                    child: Wrap(
                      children: [
                        Container(
                          height: h / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.05),
                            color: Colors.transparent,
                          ),
                          width: w,
                          child: (selectedFile != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                  child: Image.file(
                                    File(selectedFile!.path),
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Image.asset(
                                  'assets/store_cover_placeholder.jpg',
                                  fit: BoxFit.contain,
                                ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
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
                            selectedFile != null &&
                                    selectedFile!.path.isNotEmpty
                                ? Icons.edit
                                : Icons.add,
                            size: w * 0.03,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: w * 0.04,
            ),
            UserInput(
              controller: addPostNameController,
              text: 'Product name',
              //   validator: (name) => nameValidator(name, 'Enter product name'),
            ),
            UserInput(
              text: 'Product Description',
              controller: addPostDescriptionController,
            ),
            UserInput(
              text: 'Product price',
              controller: addPostPriceController,
            ),
            (w * 0.1).ph,
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
              (w * 0.08).px,
              Expanded(
                  child: BlocProvider(
                create: (context) => AddPostCubit(),
                child: BlocConsumer<AddPostCubit, AddPostState>(
                  listener: (context, state) async {
                    if (state is AddPostSucceed) {
                      CustomToast.showMessage(
                          context: context,
                          size: size,
                          message: "Post Added Successfully",
                          messageType: MessageType.SUCCESS);
                      context
                          .read<PostsCubit>()
                          .getOwnerPosts(
                            ownerID: globalSharedPreference.getString("ID")!,
                            shopID: globalSharedPreference.getString("shopID")!,
                          )
                          .then((value) => context.pop());
                    } else if (state is AddPostFailed) {
                      CustomToast.showMessage(
                          context: context,
                          size: size,
                          message: state.message,
                          messageType: MessageType.REJECTED);
                      // context.pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is AddPostProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomButton(
                      onPressed: () {
                        !formKey.currentState!.validate() &&
                                (selectedFile == null ||
                                    selectedFile!.path.isEmpty)
                            ? CustomToast.showMessage(
                                context: context,
                                size: size,
                                message: 'Please check required fields',
                                messageType: MessageType.REJECTED)
                            : {
                                formKey.currentState!.save(),
                                context.read<AddPostCubit>().addPost(
                                      postImageType: postImageType!,
                                      title: addPostNameController.text,
                                      description:
                                          addPostDescriptionController.text,
                                      postImage: imageBase64 ?? "url",
                                      category: "",
                                      price: addPostPriceController.text,
                                      shopeID: globalSharedPreference
                                          .getString("shopID")!,
                                    ),
                              };
                        // ).then((value) => context.pop());
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
                              color: AppColors.mainOrangeColor,
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
