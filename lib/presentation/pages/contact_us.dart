import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/cubit/contact_us_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';

import '../../data/enums/message_color.dart';
import '../../data/enums/message_type.dart';
import '../../logic/cubites/cubit/get_caht_messages_cubit.dart';
import '../shared/colors.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../widgets/contactUs/admin_message.dart';
import '../widgets/contactUs/no_message_yet.dart';
import '../widgets/contactUs/user_message.dart';
import '../widgets/switch_shop/error.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<dynamic> messages = [];
  bool? isMessageSelected;
  String? savedMessage;
  @override
  void initState() {
    context.read<GetCahtMessagesCubit>().getChatMessages(
        ownerID: globalSharedPreference.getString("ID") ?? '0');
    isMessageSelected = false;
    globalSharedPreference.setBool("isMessageSelected", false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageText = TextEditingController();

    var size = MediaQuery.of(context).size;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: AppColors.mainTextColor,
                  onPressed: () {
                    context.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                (size.width * 0.008).px,
                Stack(children: [
                  CircleAvatar(
                    radius: size.width * 0.065,
                    child: Image.asset(
                      'assets/admin.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: size.width * 0.15, top: size.width * 0.05),
                    child: CustomText(
                      text: LocaleKeys.admin.tr(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: size.width * 0.09, top: size.width * 0.09),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.025,
                          backgroundColor: AppColors.mainWhiteColor,
                          child: CircleAvatar(
                            radius: size.width * 0.02,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        2.px,
                        CustomText(
                          text: LocaleKeys.online.tr(),
                          textColor: Colors.green,
                          fontSize: size.width * 0.03,
                        )
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            const Divider(),
            Expanded(
              child: BlocConsumer<GetCahtMessagesCubit, GetCahtMessagesState>(
                listener: (context, state) {
                  if (state is GetCahtMessagesFailed) {
                    CustomToast.showMessage(
                        context: context,
                        size: size,
                        message: state.message.toUpperCase(),
                        messageType: MessageType.REJECTED);
                  }
                },
                builder: (context, state) {
                  if (state is GetCahtMessagesProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetCahtMessagesSucceed) {
                    if (context.read<GetCahtMessagesCubit>().messages.isEmpty) {
                      return buildNoMessagesYet(size);
                    }

                    messages = context.read<GetCahtMessagesCubit>().messages;
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (messages[index]["reply"] != null) {
                            return Expanded(
                                child: adminMessage(size, messages[index]));
                          }
                          return Expanded(
                              child: userMessage(size, messages[index]));
                        },
                        separatorBuilder: (context, index) =>
                            (size.width * 0.08).px,
                        itemCount: messages.length);
                  }
                  return buildError(size);
                },
              ),
            ),
            const Spacer(),
            Column(
              children: [
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: UserInput(
                        text: LocaleKeys.type_your_message_here.tr(),
                        controller: messageText,
                        validator: (message) {
                          if (message!.isEmpty) {
                            return LocaleKeys.type_a_right_message.tr();
                          } else if (message.length > 500) {
                            return LocaleKeys.message_less_than_500_words.tr();
                          } else if (globalSharedPreference
                                  .getBool("isMessageSelected") ==
                              false) {
                            return LocaleKeys.message_type_required.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => ContactUsCubit(),
                      child: BlocConsumer<ContactUsCubit, ContactUsState>(
                        listener: (context, state) {
                          if (state is ContactUsSucceed) {
                            CustomToast.showMessage(
                                context: context,
                                size: size,
                                message:
                                    LocaleKeys.message_sent_successfuly.tr(),
                                messageType: MessageType.SUCCESS);
                            context.pushRepalceme(const ContactUs());
                          } else if (state is ContactUsFailed) {
                            CustomToast.showMessage(
                                context: context,
                                size: size,
                                message: state.message.toUpperCase(),
                                messageType: MessageType.REJECTED);
                          }
                        },
                        builder: (context, state) {
                          if (state is ContactUsProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.all((size.width * 0.0008)),
                            child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: AppColors.mainBlueColor,
                              ),
                              onPressed: () {
                                !formKey.currentState!.validate() &&
                                        globalSharedPreference
                                                .getBool("isMessageSelected") ==
                                            false
                                    ? CustomToast.showMessage(
                                        context: context,
                                        size: size,
                                        message: LocaleKeys
                                            .please_check_required_fields
                                            .tr(),
                                        messageType: MessageType.REJECTED)
                                    : {
                                        formKey.currentState!.save(),
                                        context
                                            .read<ContactUsCubit>()
                                            .contactUS(
                                              id: globalSharedPreference
                                                  .getString("ID")!,
                                              description: messageText.text,
                                              type: globalSharedPreference
                                                      .getString(
                                                          "messageType") ??
                                                  "others",
                                            ),
                                      };
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                (size.width * 0.0008).ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          globalSharedPreference.setBool(
                              "isMessageSelected", true);

                          globalSharedPreference.setString(
                              "messageType", messageTypes[0]);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: messageColor[0],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(LocaleKeys.error.tr()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        globalSharedPreference.setBool(
                            "isMessageSelected", true);
                        globalSharedPreference.setString(
                            "messageType", messageTypes[1]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: messageColor[1],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(LocaleKeys.suggestion.tr()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        globalSharedPreference.setBool(
                            "isMessageSelected", true);
                        globalSharedPreference.setString(
                            "messageType", messageTypes[2]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: messageColor[2],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(LocaleKeys.guidance.tr()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        globalSharedPreference.setBool(
                            "isMessageSelected", true);
                        globalSharedPreference.setString(
                            "messageType", messageTypes[3]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: messageColor[3],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(LocaleKeys.others.tr()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      //),
    );
  }
}
