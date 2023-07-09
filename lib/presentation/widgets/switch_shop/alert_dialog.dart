import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

import '../../../logic/cubites/shop/delete_shop_cubit.dart';
import '../../../logic/cubites/shop/switch_shop_cubit.dart';
import '../../shared/custom_widgets/custom_text.dart';

void showAlertDialog(BuildContext context, var shop) {
  AwesomeDialog(
      btnOkColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO_REVERSED,
      body: const Center(
          child: CustomText(
        text: "Start the App with This Store?",
        bold: true,
        fontSize: 16,
      )),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        context.read<SwitchShopCubit>().setIDOfSelectedShop(id: shop["shopID"]);
        context.read<SwitchShopCubit>().swithShop(shop: shop);
      }).show();
}

void deleteShopAlert(BuildContext context, var shopID, bool isLastShop) {
  AwesomeDialog(
      btnOkColor: AppColors.mainRedColor,
      btnCancelColor: Colors.green,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO_REVERSED,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
            child: isLastShop == false
                ? const CustomText(
                    text:
                        "You Will Delete This Shop  and It's Posts You Can't Restore  it !")
                : const CustomText(
                    text:
                        "You Will Delete This Shop  and It's Posts You Can't Restore  Any Thing ,  You Will Lose Owner power And become Normal User !")),
      ),
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnOkText: " Countinue",
      btnOkOnPress: () {
        context.read<DeleteShopCubit>().deleteShop(shopID: shopID);
      }).show();
}
