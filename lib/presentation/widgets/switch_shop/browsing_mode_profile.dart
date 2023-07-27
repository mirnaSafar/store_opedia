import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_text.dart';

Widget browsingModeProfile(var size) {
  return Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        30.ph,
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: AppColors.secondaryFontColor,
              borderRadius: BorderRadius.circular(20)),
          width: size.width / 1.2,
          child: const CustomText(
              fontSize: 20,
              textColor: Colors.white,
              text:
                  'you don\'t have an account , \nplease create one and try again'),
        ),
        Positioned(
          top: -30,
          right: -30,
          child: SvgPicture.asset(
            "assets/rejected-01.svg",
            height: 70,
            // width: 50,
          ),
        ),
      ],
    ),
  );
}
