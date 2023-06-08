import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/pages/edit_post.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/product/product_info.dart';

import '../../shared/custom_widgets/custom_text.dart';

class ProductPost extends StatefulWidget {
  const ProductPost({Key? key}) : super(key: key);

  @override
  State<ProductPost> createState() => _ProductPostState();
}

class _ProductPostState extends State<ProductPost> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: w * 0.065,
                    backgroundColor: AppColors.mainTextColor,
                    // child: Image.asset('assets/verified.png', fit: BoxFit.cover),
                  ),
                  10.px,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'store name',
                        // bold: true,
                      ),
                      CustomText(
                        text: 'clothes',
                        fontSize: w * 0.03,
                        textColor: AppColors.mainTextColor,
                      ),
                    ],
                  ),
                ],
              ),

              // 190.px,
              IconButton(
                  onPressed: () => context.push(const EditPostPage()),
                  icon: const Icon(Icons.location_on_outlined))
            ],
          ),
        ),
        20.ph,
        Container(
          height: h / 5,
          color: AppColors.mainBlackColor,
        ),
        20.ph,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: 'product name'),
                  5.ph,
                  const CustomRate(),
                ],
              ),
              // 190.px,
              Row(
                children: [
                  const Icon(Icons.favorite_border_outlined),
                  10.px,
                  InkWell(
                      onTap: () => context.push(const ProductInfo()),
                      child: const Icon(Icons.info_outline)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
