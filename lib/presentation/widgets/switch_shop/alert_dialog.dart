import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
