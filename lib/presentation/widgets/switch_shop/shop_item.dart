import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/deactivate_shop_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/alert_dialog.dart';
import '../../../data/enums/message_type.dart';
import '../../../logic/cubites/shop/delete_shop_cubit.dart';
import '../../../logic/cubites/shop/switch_shop_cubit.dart';
import '../../../main.dart';
import '../../pages/control_page.dart';
import '../../pages/switch_store.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../dialogs/awosem_dialog.dart';

Widget buildShopItem(BuildContext context, Size size, var shop, bool isLastShop,
        String? currentShopID) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: size.width * 0.12,
              backgroundColor: AppColors.mainTextColor,
              backgroundImage: FileImage(File(shop["shopProfileImage"] != 'url'
                  ? shop["shopProfileImage"]
                  : '')),
              child: shop["shopProfileImage"] == 'url'
                  ? ClipOval(
                      child: Image.asset(
                        'assets/store_placeholder.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  : null),
          40.px,
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: shop["shopName"],
                      bold: true,
                      fontSize: 20,
                    ),
                    30.px,
                    Icon(
                      Icons.people_alt_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.px,
                    CustomText(text: shop["followesNumber"].toString()),
                    40.px,
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.px,
                    CustomText(text: shop["rate"].toString()),
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    BlocConsumer<SwitchShopCubit, SwitchShopState>(
                      listener: (context, state) {
                        if (state is SwithShopFiled) {
                          buildAwsomeDialog(
                              context, "Filed", "OK", "Select Store Filed",
                              type: DialogType.ERROR);
                        } else if (state is SwithShopSucceded) {
                          context.read<AuthCubit>().selectedShop();

                          /* context
                              .read<SwitchShopCubit>()
                              .setIDOfSelectedShop(id: shop["shopID"]);*/

                          context.pushRepalceme(const ControlPage());
                        }
                      },
                      builder: (context, state) {
                        if (state is SwithShopSucceded &&
                            currentShopID == shop["shopID"]) {
                          return const CustomText(
                            text: "Current Shop",
                            textColor: Colors.green,
                          );
                        } else if (state is SwithShopProgress &&
                            currentShopID == shop["shopID"]) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SwithShopProgress &&
                            currentShopID != shop["shopID"]) {
                          return CustomText(
                            text: "Waiting....",
                            textColor: Theme.of(context).primaryColorDark,
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            showAlertDialog(context, shop);
                          },
                          child: const Text("Select the Store"),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        );
                      },
                    ),
                    30.px,
                    BlocProvider(
                      create: (context) => DeleteShopCubit(),
                      child: Visibility(
                          visible: currentShopID != "noID",
                          child: BlocConsumer<DeleteShopCubit, DeleteShopState>(
                            listener: (context, state) {
                              if (state is DeleteShopSucceed) {
                                if (currentShopID == shop["shopID"]) {
                                  AuthCubit().deleteCurrentShop();
                                }
                                isLastShop == false
                                    ? {
                                        CustomToast.showMessage(
                                            context: context,
                                            size: size,
                                            message: 'Shop Delete',
                                            messageType: MessageType.SUCCESS),
                                        context
                                            .pushRepalceme(const SwitchStore())
                                      }
                                    : {
                                        CustomToast.showMessage(
                                            context: context,
                                            size: size,
                                            message: 'Shop Delete',
                                            messageType: MessageType.SUCCESS),
                                        context
                                            .pushRepalceme(const ControlPage()),
                                        context
                                            .read<AuthCubit>()
                                            .ownerBecomeUser()
                                      };
                              } else if (state is DeleteShopFailed) {
                                CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: 'Failed',
                                    messageType: MessageType.WARNING);
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteShopProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  deleteShopAlert(
                                      context, shop["shopID"], isLastShop);
                                },
                                child: const Text("Delete"),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: AppColors.mainRedColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              );
                            },
                          )),
                    ),
                    30.px,
                    BlocProvider(
                      create: (context) => DeactivateShopCubit(),
                      child: Visibility(
                          visible: currentShopID != "noID",
                          child: BlocConsumer<DeactivateShopCubit,
                              DeactivateShopState>(
                            listener: (context, state) {
                              if (state is DeactivateShopSucceed) {
                                isLastShop == false
                                    ? {
                                        CustomToast.showMessage(
                                            context: context,
                                            size: size,
                                            message: 'Shop Deacivated',
                                            messageType: MessageType.SUCCESS),
                                        context
                                            .pushRepalceme(const SwitchStore())
                                      }
                                    : {
                                        CustomToast.showMessage(
                                            context: context,
                                            size: size,
                                            message: 'Shop Deacivated',
                                            messageType: MessageType.SUCCESS),
                                        globalSharedPreference.setBool(
                                            "hasDeacyivaedStore", true),
                                        context
                                            .pushRepalceme(const ControlPage()),
                                        context
                                            .read<AuthCubit>()
                                            .ownerBecomeUser()
                                      };
                              } else if (state is DeactivateShopFailed) {
                                CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: state.message.toUpperCase(),
                                    messageType: MessageType.WARNING);
                              }
                            },
                            builder: (context, state) {
                              if (state is DeactivateShopProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  deactivatedShopAlert(
                                      context, shop["shopID"], isLastShop);
                                },
                                child: const Text("Deactivate"),
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
