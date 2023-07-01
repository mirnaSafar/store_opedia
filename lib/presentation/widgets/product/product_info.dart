import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainWhiteColor,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              20.px,
              CircleAvatar(
                radius: w * 0.065,
                backgroundColor: AppColors.mainTextColor,
                // child: Image.asset('assets/verified.png', fit: BoxFit.cover),
              ),
              10.px,
              const CustomText(
                text: 'store name',
                // bold: true,
              ),
              // CustomText(
              //   text: 'clothes',
              //   fontSize: w * 0.03,
              //   textColor: AppColors.mainTextColor,
              // ),
              // 190.px,
              // const Icon(Icons.location_on_outlined)
            ],
          ),
          20.ph,
          Container(
            height: h / 5,
            color: AppColors.mainBlackColor,
          ),
          20.ph,
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.px,
              Icon(
                Icons.favorite_border_outlined,
                size: w * 0.06,
              ),
              // const CustomText(text: 'product name'),
              15.px,
              BlocBuilder<RatePostCubit, RatePostState>(
                builder: (context, state) {
                  return CustomRate(
                    enableRate: true,
                    post: widget.post,
                    size: w * 0.035,
                  );
                },
              ),
            ],
          ),
          const CustomDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0),
                  child: CustomText(
                    text: widget.post.title,
                    fontSize: w * 0.04,
                  ),
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.tag,
                      color: AppColors.secondaryFontColor,
                    ),
                    20.px,
                    CustomText(
                      text: widget.post.category,
                      textColor: AppColors.secondaryFontColor,
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    const Icon(
                      Icons.price_change,
                      color: Colors.green,
                    ),
                    20.px,
                    CustomText(
                      text: widget.post.price,
                      textColor: AppColors.secondaryFontColor,
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.short_text_rounded,
                      color: AppColors.secondaryFontColor,
                    ),
                    20.px,
                    CustomText(
                      text: widget.post.description,
                      textColor: AppColors.secondaryFontColor,
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.mainBlueColor,
                    ),
                    20.px,
                    CustomText(
                      text: 'widget.post.location',
                      textColor: AppColors.secondaryFontColor,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => connectionDialog(),
                    ),
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: AppColors.mainOrangeColor,
                      size: w * 0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget connectionDialog() {
    return Dialog(
      shadowColor: AppColors.mainBlackColor,
      // backgroundColor: AppColors.mainBlueColor,
      surfaceTintColor: Colors.transparent,
      alignment: Alignment.bottomRight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetPadding: const EdgeInsets.only(bottom: 250, right: 40, left: 315),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        // color: AppColors.mainBlueColor,
        // width: 190,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.phone,
                size: 30,
              ),
              40.ph,
              const Icon(
                Icons.mail_outline_outlined,
                size: 30,
              ),
              40.ph,
              const Icon(
                Icons.facebook,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
