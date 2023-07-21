import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import '../../logic/cubites/shop/get_owner_shops_cubit.dart';
import '../../main.dart';
import '../widgets/dialogs/awosem_dialog.dart';
import '../widgets/switch_shop/deactive_shop_item.dart';
import '../widgets/switch_shop/error.dart';
import '../widgets/switch_shop/no_deactivated_shops.dart';

class DeactiveStores extends StatefulWidget {
  const DeactiveStores({Key? key}) : super(key: key);

  @override
  State<DeactiveStores> createState() => _DeactiveStoresState();
}

class _DeactiveStoresState extends State<DeactiveStores> {
  List<dynamic> ownerDeactivateShpos = [];
  bool isLastShop = false;
  @override
  void initState() {
    if (ownerDeactivateShpos.isEmpty) {
      context.read<GetOwnerShopsCubit>().getOwnerShopsRequest(
          ownerID: globalSharedPreference.getString("ID"), message: "deactive");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Deactive Shops"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: BlocConsumer<GetOwnerShopsCubit, GetOwnerShopsState>(
            listener: (context, state) {
              if (state is GetOwnerShopsFiled) {
                buildAwsomeDialog(
                        context, "Filed", state.message.toUpperCase(), "OK",
                        type: DialogType.ERROR)
                    .show();
              } else if (state is GetOwnerShopsSucceed) {}
            },
            builder: (context, state) {
              if (state is GetOwnerShopsProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetOwnerShopsSucceed) {
                ownerDeactivateShpos =
                    BlocProvider.of<GetOwnerShopsCubit>(context).ownerShops;

                if (ownerDeactivateShpos.length == 1) {
                  isLastShop = true;
                }
                if (ownerDeactivateShpos.isEmpty) {
                  return buildNoShopItems(
                      size, "You Don't Have Deactivated Shops !");
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildDeactivatedShopItem(context, size,
                          ownerDeactivateShpos[index], isLastShop);
                    },
                    separatorBuilder: (context, index) => const CustomDivider(),
                    itemCount: ownerDeactivateShpos.length);
              }
              return buildError(size);
            },
          ),
        ));
  }
}
