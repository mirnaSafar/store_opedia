import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class SuggestedStore extends StatefulWidget {
  const SuggestedStore({Key? key}) : super(key: key);

  @override
  State<SuggestedStore> createState() => _SuggestedStoreState();
}

class _SuggestedStoreState extends State<SuggestedStore> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        CircleAvatar(
          radius: w * 0.12,
          // child: Image.asset(''),
          backgroundColor: AppColors.mainBlueColor,
        ),
        20.px,
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: 'Store',
                  fontSize: w * 0.045,
                  bold: true,
                ),
                170.px,
                const Icon(Icons.menu)
              ],
            ),
            25.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomRate(),
                5.px,
                // CustomText(
                //   text: 'category',
                //   fontSize: w * 0.035,
                // ),
                35.px,
                Icon(Icons.location_on, size: w * 0.04),
                5.px,
                CustomText(
                  text: 'Hama',
                  fontSize: w * 0.035,
                ),
                35.px,
                Icon(Icons.comment, size: w * 0.04),
                5.px,
                CustomText(
                  text: 'category',
                  fontSize: w * 0.035,
                ),
              ],
            ),
          ],
        ),
        // const Icon(Icons.menu)
      ],
    );
  }
}
