import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';

import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/alert_dialog.dart';
import '../../../data/enums/message_type.dart';
import '../../../logic/cubites/shop/active_shop_cubit.dart';
import '../../../logic/cubites/shop/deactivate_shop_cubit.dart';
import '../../../logic/cubites/shop/delete_shop_cubit.dart';
import '../../../logic/cubites/shop/switch_shop_cubit.dart';
import '../../../main.dart';
import '../../pages/control_page.dart';
import '../../pages/switch_store.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../dialogs/awosem_dialog.dart';

Widget buildShopItem(
        BuildContext context, Size size, var shop, bool isLastShop) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: size.width * 0.12,
              backgroundColor: AppColors.mainTextColor,
              child: shop["shopProfileImage"] == 'url'
                  ? ClipOval(
                      child: Image.asset(
                        'assets/store_placeholder.png',
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.network(
                      shop["shopProfileImage"],
                      fit: BoxFit.fill,
                    )),
          15.px,
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
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    BlocConsumer<SwitchShopCubit, SwitchShopState>(
                      listener: (context, state) {
                        if (state is SwithShopFiled) {
                          buildAwsomeDialog(
                              context, "Failed", "OK", "Select Store Failed",
                              type: DialogType.ERROR);
                        } else if (state is SwithShopSucceded) {
                          context.read<AuthCubit>().selectedShop();

                          context.pushRepalceme(const ControlPage());
                        }
                      },
                      builder: (context, state) {
                        if (state is SwithShopSucceded &&
                            globalSharedPreference.getString("shopID") ==
                                shop["shopID"]) {
                          return const Expanded(
                            child: CustomText(
                              text: "Current Shop",
                              textColor: Colors.green,
                            ),
                          );
                        } else if (state is SwithShopProgress &&
                            globalSharedPreference.getString("shopID") ==
                                shop["shopID"]) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SwithShopProgress &&
                            globalSharedPreference.getString("shopID") !=
                                shop["shopID"]) {
                          return Expanded(
                            child: CustomText(
                              text: "Waiting...",
                              textColor: Theme.of(context).primaryColorDark,
                            ),
                          );
                        }
                        return Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, shop);
                            },
                            child: const Text("Select"),
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        );
                      },
                    ),
                    5.px,
                    Visibility(
                      visible: shop["is_active"] == false &&
                          globalSharedPreference.getString("shopID") != "noID",
                      child: BlocProvider(
                        create: (context) => ActiveShopCubit(),
                        child: Row(children: [
                          BlocConsumer<ActiveShopCubit, ActiveShopState>(
                            listener: (context, state) {
                              if (state is ActiveShopSucceed) {
                                CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: 'Shop Acivated',
                                    messageType: MessageType.SUCCESS);
                                if (globalSharedPreference
                                        .getString("shopID") ==
                                    shop["shopID"]) {
                                  globalSharedPreference.setBool(
                                      "isActive", true);
                                }
                                context.pushRepalceme(const SwitchStore());
                              } else if (state is ActiveShopFailed) {
                                CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: state.message.toUpperCase(),
                                    messageType: MessageType.WARNING);
                              }
                            },
                            builder: (context, state) {
                              if (state is ActiveProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    activeShopAlert(context, shop["shopID"]);
                                  },
                                  child: const Text("Activate"),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              );
                            },
                          ),
                        ]),
                      ),
                    ),
                    0.px,
                    BlocProvider(
                      create: (context) => DeactivateShopCubit(),
                      child: Visibility(
                          visible: globalSharedPreference.getString("shopID") !=
                                  "noID" &&
                              shop["is_active"],
                          child: BlocConsumer<DeactivateShopCubit,
                              DeactivateShopState>(
                            listener: (context, state) {
                              if (state is DeactivateShopSucceed) {
                                if (globalSharedPreference
                                        .getString("shopID")! ==
                                    shop["shopID"]) {
                                  globalSharedPreference.setBool(
                                      "isActive", false);
                                }
                                CustomToast.showMessage(
                                    context: context,
                                    size: size,
                                    message: 'Shop Deacivated',
                                    messageType: MessageType.SUCCESS);
                                context.pushRepalceme(const SwitchStore());
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
                              return Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    isLastShop == false
                                        ? deactivatedShopAlert(
                                            context, shop["shopID"])
                                        : cantDeactivatedShop(context);
                                  },
                                  child: const Text("Deactivate"),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      backgroundColor: Colors.blueGrey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              );
                            },
                          )),
                    ),
                    5.px,
                    BlocProvider(
                      create: (context) => DeleteShopCubit(),
                      child: Visibility(
                          visible: globalSharedPreference.getString("shopID") !=
                                  "noID" &&
                              shop["is_active"],
                          child: BlocConsumer<DeleteShopCubit, DeleteShopState>(
                            listener: (context, state) {
                              if (state is DeleteShopSucceed) {
                                if (globalSharedPreference
                                        .getString("shopID") ==
                                    shop["shopID"]) {
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
                                            .ownerBecomeUser(),
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
                              return Expanded(
                                child: ElevatedButton(
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
                                ),
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
