import 'package:flutter/material.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';

class SuggestedStoresView extends StatefulWidget {
  const SuggestedStoresView({Key? key}) : super(key: key);

  @override
  State<SuggestedStoresView> createState() => _SuggestedStoresViewState();
}

class _SuggestedStoresViewState extends State<SuggestedStoresView> {
  List<Shop> suggestedStoresList = [];
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: PageHeader(),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              separatorBuilder: (BuildContext context, int index) {
                return const SuggestedStore();
              },
              itemBuilder: (BuildContext context, int index) {
                return const CustomDivider();
              },
            ),
          ],
          // ),
        ),
      ),
    );
  }
}
