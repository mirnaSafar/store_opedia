import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import '../../logic/cubites/shop/get_owner_shops_cubit.dart';
import '../../main.dart';
import '../widgets/dialogs/awosem_dialog.dart';
import '../widgets/switch_shop/error.dart';
import '../widgets/switch_shop/no_deactivated_shops.dart';
import '../widgets/switch_shop/shop_item.dart';

class SwitchStore extends StatefulWidget {
  const SwitchStore({Key? key}) : super(key: key);

  @override
  State<SwitchStore> createState() => _SwitchStoreState();
}

class _SwitchStoreState extends State<SwitchStore> {
  List<dynamic> ownerShpos = [];
  bool isLastShop = false;
  @override
  void initState() {
    if (ownerShpos.isEmpty) {
      context.read<GetOwnerShopsCubit>().getOwnerShopsRequest(
          ownerID: globalSharedPreference.getString("ID"), message: "active");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Shops"),
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
                ownerShpos =
                    BlocProvider.of<GetOwnerShopsCubit>(context).ownerShops;
                //    print(ownerShpos);
                if (ownerShpos.length == 1) {
                  isLastShop = true;
                }
                if (ownerShpos.isEmpty) {
                  return buildNoShopItems(
                      size, "You Don't Have  any Activated Shops Yet !");
                }

                return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildShopItem(
                          context, size, ownerShpos[index], isLastShop);
                    },
                    separatorBuilder: (context, index) => const CustomDivider(),
                    itemCount: ownerShpos.length);
              }
              return buildError(size);
            },
          ),
        ));
  }
}
