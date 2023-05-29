import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/logic/cubites/cubit/following_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/work_time_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

import '../widgets/product/product_post.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Post> postList = [];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                // alignment: AlignmentDirectional.topCenter,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/verified.png',
                      fit: BoxFit.fitWidth,
                    ),
                    height: h / 5,
                    width: w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: h * 0.15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.mainWhiteColor,
                              radius: w * 0.12,
                              child: CircleAvatar(
                                radius: w * 0.11,
                                backgroundColor: AppColors.mainTextColor,
                                // child: Image.asset('assets/verified.png', fit: BoxFit.cover),
                              ),
                            ),
                            BlocBuilder<WorkTimeCubit, WorkTimeState>(
                              builder: (context, state) {
                                return Visibility(
                                  visible: state.isOpen == true,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: w * 0.2, top: w * 0.16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: w * 0.025,
                                          backgroundColor:
                                              AppColors.mainWhiteColor,
                                          child: CircleAvatar(
                                            radius: w * 0.02,
                                            backgroundColor: Colors.green,
                                          ),
                                        ),
                                        2.px,
                                        CustomText(
                                          text: 'Open now',
                                          textColor: Colors.green,
                                          fontSize: w * 0.03,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: w * 0.01),
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Store name',
                                bold: true,
                                fontSize: w * 0.05,
                                textColor: AppColors.mainBlackColor,
                              ),
                              10.px,
                              const CustomRate(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              10.ph,
              Row(
                children: [
                  Icon(
                    Icons.tag,
                    color: Colors.grey.shade300,
                  ),
                  10.px,
                  CustomText(
                    text: 'clothes',
                    textColor: Colors.grey.shade300,
                  ),
                ],
              ),
              10.ph,
              CustomText(
                  textColor: AppColors.mainTextColor,
                  text: 'basic description about the store and its major'),
              30.ph,
              Row(
                children: [
                  CustomText(
                    text: '1k Followers',
                    textColor: AppColors.mainBlueColor,
                  ),
                  70.px,
                  BlocBuilder<FollowingCubit, FollowingState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => state.followed = !state.followed,
                        child: CustomText(
                          text: state.followed ? 'Following' : 'Follow',
                          textColor: AppColors.mainBlueColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const CustomDivider(),
              const CustomIconTextRow(
                  icon: Icons.alarm, text: 'Work hours:   8am-2pm'),
              20.ph,
              const CustomIconTextRow(icon: Icons.phone, text: '0987655432'),
              20.ph,
              const CustomIconTextRow(
                  icon: Icons.email, text: 'name@gmail.com'),
              20.ph,
              const CustomIconTextRow(
                  icon: Icons.location_on_outlined, text: 'Hamah'),
              const CustomDivider(),
              CustomText(
                text: 'Social accounts',
                textColor: AppColors.mainBlackColor,
                fontSize: w * 0.04,
                bold: true,
              ),
              20.ph,
              const CustomIconTextRow(
                  icon: Icons.facebook, text: 'https://instagram.com'),
              10.ph,
              const CustomIconTextRow(
                  icon: Icons.facebook, text: 'https://instagram.com'),
              const CustomDivider(),
            ]),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: w * 0.06),
            child: CustomText(
              text: 'Related Stores',
              textColor: AppColors.mainBlackColor,
              fontSize: w * 0.04,
              bold: true,
            ),
          ),
          20.ph,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: h / 7,
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return 20.px;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: w * 0.11,
                          backgroundColor: AppColors.mainTextColor,
                        ),
                        5.ph,
                        const CustomText(text: 'store name')
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          const CustomDivider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: postList.length,
            separatorBuilder: (context, index) => const CustomDivider(),
            itemBuilder: (BuildContext context, int index) {
              return const ProductPost();
            },
          ),
        ],
      ),
    );
  }
}
