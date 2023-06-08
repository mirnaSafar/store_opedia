import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/pages/store_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
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
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (context) {
                            return Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(w * 0.1),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              context.push(const StorePage()),
                                          child: CustomIconTextRow(
                                              fontSize: w * 0.04,
                                              iconColor:
                                                  AppColors.mainBlackColor,
                                              icon: Icons.storefront,
                                              text: 'View Profile'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30.0),
                                          child: InkWell(
                                            onTap: () => {},
                                            child: CustomIconTextRow(
                                                fontSize: w * 0.04,
                                                iconColor:
                                                    AppColors.mainBlackColor,
                                                icon: Icons.star,
                                                text: 'Add to favorites'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: CustomIconTextRow(
                                              fontSize: w * 0.04,
                                              iconColor:
                                                  AppColors.mainBlackColor,
                                              icon: Icons
                                                  .person_add_alt_1_rounded,
                                              text: 'Follow Store'),
                                        ),
                                      ]),
                                ),
                              ],
                            );
                          });
                    },
                  )
                ],
              ),
              5.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomRate(),

                  // CustomText(
                  //   text: 'category',
                  //   fontSize: w * 0.035,
                  // ),
                  20.px,
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, size: w * 0.04)),

                  CustomText(
                    text: 'Hama',
                    fontSize: w * 0.035,
                  ),
                  20.px,
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  )),
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: h * 0.3, horizontal: h * 0.01),
                                  child: Wrap(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(w * 0.06),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const CustomText(
                                                  text: 'Stores Category',
                                                  bold: true,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                    icon:
                                                        const Icon(Icons.close))
                                              ],
                                            ),
                                            const Divider(),
                                            10.ph,
                                            CustomText(
                                              text: 'Store category',
                                              textColor:
                                                  AppColors.secondaryFontColor,
                                            ),
                                            10.ph,
                                            CustomText(
                                              text: 'Store category',
                                              textColor:
                                                  AppColors.secondaryFontColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      icon: Icon(Icons.comment, size: w * 0.04)),

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
      ),
    );
  }
}
