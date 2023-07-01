import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/alert_dialog.dart';

import '../../../logic/cubites/shop/switch_shop_cubit.dart';
import '../../pages/control_page.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../dialogs/awosem_dialog.dart';

Widget buildShopItem(BuildContext context, var height, var shop) => Padding(
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
                    50.px,
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
                        context.read<SwitchShopCubit>().getStoredShopID();
                        print(context.read<SwitchShopCubit>().idofSelectedShop);
                        if (state is SwithShopSucceded &&
                            context.read<SwitchShopCubit>().idofSelectedShop ==
                                shop["shopID"]) {
                          return CustomText(
                            text: "Current Shop",
                            textColor: Theme.of(context).primaryColorDark,
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
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.px,
                    CustomText(text: shop["location"]),
                    50.px,
                    Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.px,
                    CustomText(text: shop["followesNumber"].toString()),
                    50.px,
                    Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    5.px,
                    CustomText(text: shop["rate"].toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
