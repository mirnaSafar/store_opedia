import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/store_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';
import '../widgets/suggested_store/no_shop_yet.dart';
import '../widgets/switch_shop/error.dart';

class SuggestedStoresView extends StatefulWidget {
  const SuggestedStoresView({Key? key}) : super(key: key);

  @override
  State<SuggestedStoresView> createState() => _SuggestedStoresViewState();
}

class _SuggestedStoresViewState extends State<SuggestedStoresView> {
  List<dynamic> suggestedStoresList = [];

  @override
  void initState() {
    if (suggestedStoresList.isEmpty) {
      context.read<StoreCubit>().getAllStores();
    }

    super.initState();
  }

  /*  Shop(
        shopCategory: 'shopCategory',
        location: 'homs',
        startWorkTime: '12:00 AM',
        endWorkTime: '02:00 PM',
        ownerID: '3',
        ownerEmail: 'ownerEmail@gmail.com',
        ownerPhoneNumber: '0987655432',
        shopID: '1',
        shopName: 'josef',
        ownerName: 'jack'),
    Shop(
        shopCategory: 'shopCategory',
        location: 'hama',
        startWorkTime: '09:00 AM',
        endWorkTime: '02:00 PM',
        ownerID: '1',
        ownerEmail: 'ownerEmail@gmail.com',
        ownerPhoneNumber: '0987655432',
        shopID: '1',
        shopName: 'xo',
        ownerName: 'ali'),
    Shop(
        shopCategory: 'shopCategory',
        location: 'slamiah',
        startWorkTime: '09:00 AM',
        endWorkTime: '02:00 PM',
        ownerID: '2',
        ownerEmail: 'ownerEmail@gmail.com',
        ownerPhoneNumber: '0987655432',
        shopID: '4',
        shopName: 'stones',
        ownerName: 'jack')
  ];*/
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
        //  BlocListener<InternetCubit, InternetState>(
        //   listener: (context, state) async {
        //     if (state is InternetConnected) {
        //       suggestedStoresList
        //           .addAll(await context.read<ShopCubit>().getStores());
        //     } else if (state is InternetDisconnected) {
        //     } else {
        //       const CircularProgressIndicator();
        //     }
        //   },
        // child:
        RefreshIndicator(
      onRefresh: () async {
        await context.read<StoreCubit>().getAllStores();
      },
      child: Scaffold(body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: PageHeader(),
                  ),
                  30.ph,
                  BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                    if (state is FeatchingShopsProgress) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is NoShopsYet) {
                      return buildNoShopsYet(size);
                    } else if (state is FeatchingShopsSucceed) {
                      suggestedStoresList = context.read<StoreCubit>().shops;

                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: suggestedStoresList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const CustomDivider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return SuggestedStore(
                            shop: Shop.fromMap(suggestedStoresList[index]),
                          );
                        },
                      );
                    }
                    return buildError(size);
                  }),
                ],
              ));
        },
      )
          // ),
          // );
          ),
    );
  }
}
