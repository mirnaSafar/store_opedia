import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/utils.dart';

class CustomRate extends StatelessWidget {
  const CustomRate({Key? key, this.size}) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible:
                  true, // set to false if you want to force a rating
              builder: (context) => storeDialog,
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.mainOrangeColor,
                size: size ?? w * 0.03,
              ),
              CustomText(
                text: '5.0',
                textColor: AppColors.mainOrangeColor,
                fontSize: size ?? w * 0.03,
              )
            ],
          ),
        ),
      ],
    );
  }
}
