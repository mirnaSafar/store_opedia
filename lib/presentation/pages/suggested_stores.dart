import 'package:flutter/material.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';

import '../shared/colors.dart';

class SuggestedStoresView extends StatefulWidget {
  const SuggestedStoresView({Key? key}) : super(key: key);

  @override
  State<SuggestedStoresView> createState() => _SuggestedStoresViewState();
}

class _SuggestedStoresViewState extends State<SuggestedStoresView> {
  List<Shop> suggestedStoresList = [
    Shop(
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
  ];
  @override
  Widget build(BuildContext context) {
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
        Scaffold(
            backgroundColor: AppColors.mainWhiteColor,
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ListView(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: PageHeader(),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: suggestedStoresList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SuggestedStore(
                          shop: suggestedStoresList[index],
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return const CustomDivider();
                      },
                    ),
                  ],
                ))
            // ),
            // );
            );
  }
}
