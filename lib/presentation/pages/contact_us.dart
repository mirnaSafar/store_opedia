import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/cubit/contact_us_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_button.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../data/enums/message_type.dart';
import '../shared/colors.dart';
import '../shared/custom_widgets/custom_toast.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

//NOT Working NOW , still update
class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    TextEditingController messageType = TextEditingController();
    var size = MediaQuery.of(context).size;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact US"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (size.width * 0.08)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.help,
                size: (size.width * 0.3),
                color: AppColors.mainBlueColor,
              ),
              (size.width * 0.08).ph,
              UserInput(
                text: "Message Type",
                controller: message,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Can't be Empty ";
                  }
                  return null;
                },
              ),
              (size.width * 0.008).ph,
              UserInput(
                text: "Message",
                controller: messageType,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Can't be Empty";
                  }
                  return null;
                },
              ),
              (size.width * 0.08).ph,
              Row(
                children: [
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
                  (size.width * 0.08).px,
                  Expanded(
                      child: BlocProvider(
                    create: (context) => ContactUsCubit(),
                    child: BlocConsumer<ContactUsCubit, ContactUsState>(
                      listener: (context, state) {
                        if (state is ContactUsSucceed) {
                          CustomToast.showMessage(
                              context: context,
                              size: size,
                              message:
                                  'Message sent  successfully , we Will replay as soon as possible, check your gmail inbox',
                              messageType: MessageType.SUCCESS);
                        } else if (state is ContactUsFailed) {
                          CustomToast.showMessage(
                              context: context,
                              size: size,
                              message: state.message,
                              messageType: MessageType.REJECTED);
                        }
                      },
                      builder: (context, state) {
                        if (state is ContactUsProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          onPressed: () {
                            !formKey.currentState!.validate()
                                ? CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: 'Please check required fields',
                                    messageType: MessageType.REJECTED)
                                : {
                                    formKey.currentState!.save(),
                                    context.read<ContactUsCubit>().contactUS(
                                          id: globalSharedPreference
                                              .getString("ID")!,
                                          description: message.text,
                                          type: messageType.text,
                                        ),
                                  };
                          },
                          text: "Submit",
                        );
                      },
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
