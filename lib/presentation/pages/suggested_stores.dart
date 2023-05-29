import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';

class SuggestedStoresView extends StatefulWidget {
  const SuggestedStoresView({Key? key}) : super(key: key);

  @override
  State<SuggestedStoresView> createState() => _SuggestedStoresViewState();
}

class _SuggestedStoresViewState extends State<SuggestedStoresView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const PageHeader(),
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
      ),
    );
  }
}
