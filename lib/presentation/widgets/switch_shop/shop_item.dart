import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/pages/login_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/alert_dialog.dart';
import '../../../data/enums/message_type.dart';
import '../../../logic/cubites/shop/delete_shop_cubit.dart';
import '../../../logic/cubites/shop/get_owner_shops_cubit.dart';
import '../../../logic/cubites/shop/switch_shop_cubit.dart';
import '../../pages/control_page.dart';
import '../../pages/switch_store.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../dialogs/awosem_dialog.dart';

Widget buildShopItem(
        BuildContext context, var size, var shop, bool isLastShop) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 60,
            child: Image.asset('assets/verified.png'),
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: shop["shopName"],
                      bold: true,
                      fontSize: 20,
                    ),
                    30.px,
                    BlocConsumer<SwitchShopCubit, SwitchShopState>(
                      listener: (context, state) {
                        if (state is SwithShopFiled) {
                          buildAwsomeDialog(
                              context, "Filed", "OK", "Select Store Filed",
                              type: DialogType.ERROR);
                        } else if (state is SwithShopSucceded) {
                          context.read<AuthCubit>().selectedShop();

                          context.pushRepalceme(const ControlPage());
                        }
                      },
                      builder: (context, state) {
                        if (state is SwithShopSucceded &&
                            context.read<SwitchShopCubit>().idofSelectedShop ==
                                shop["shopID"]) {
                          return const CustomText(
                            text: "Current Shop",
                            textColor: Colors.green,
                          );
                        } else if (state is SwithShopProgress &&
                            context.read<SwitchShopCubit>().idofSelectedShop ==
                                shop["shopID"]) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SwithShopProgress &&
                            context.read<SwitchShopCubit>().idofSelectedShop !=
                                shop["shopID"]) {
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
                  ],
                ),
                20.ph,
                Row(
                  children: [
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
                    40.px,
                    BlocProvider(
                      create: (context) => DeleteShopCubit(),
                      child: Visibility(
                          visible: context
                                  .read<SwitchShopCubit>()
                                  .idofSelectedShop !=
                              "noID",
                          child: BlocConsumer<DeleteShopCubit, DeleteShopState>(
                            listener: (context, state) {
                              if (state is DeleteShopSucceed) {
                                if (context
                                        .read<SwitchShopCubit>()
                                        .idofSelectedShop ==
                                    shop["shopID"]) {
                                  AuthCubit().deleteCurrentShop();
                                  globalSharedPreference.setString(
                                      "currentShop", "notSelected");
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
                              return IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors.mainRedColor,
                                ),
                                onPressed: () {
                                  deleteShopAlert(
                                      context, shop["shopID"], isLastShop);
                                },
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
