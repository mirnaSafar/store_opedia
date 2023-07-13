import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/logic/cubites/shop/favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/shop_follwers_counter_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/presentation/pages/store_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class SuggestedStore extends StatefulWidget {
  SuggestedStore({Key? key, required this.shop}) : super(key: key);
  Shop shop;
  @override
  State<SuggestedStore> createState() => _SuggestedStoreState();
}

class _SuggestedStoreState extends State<SuggestedStore> {
  late FavoriteCubit read;
  late FollowingCubit followingCubit;
  // late Shop shop;
  @override
  void initState() {
    read = context.read<FavoriteCubit>();
    followingCubit = context.read<FollowingCubit>();
    // shop = SharedPreferencesRepository.getSavedShop(widget.shop) ?? widget.shop;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shop =
        SharedPreferencesRepository.getSavedShop(widget.shop) ?? widget.shop;

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
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
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: w / 7,
                    child: CustomText(
                      text: shop.shopName,
                      fontSize: w * 0.045,
                      bold: true,
                    ),
                  ),
                  120.px,
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
                                          onTap: () {
                                            context
                                                .read<WorkTimeCubit>()
                                                .testOpenTime(
                                                    openTime:
                                                        shop.startWorkTime,
                                                    closeTime:
                                                        shop.endWorkTime);
                                            context.push(StorePage(
                                              shop: shop,
                                            ));
                                          },
                                          child: CustomIconTextRow(
                                              fontSize: w * 0.04,
                                              iconColor:
                                                  AppColors.mainBlackColor,
                                              icon: Icons.storefront,
                                              text: 'View Profile'),
                                        ),
                                        BlocBuilder<FavoriteCubit,
                                            FavoriteState>(
                                          builder: (context, state) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 30.0),
                                              child: InkWell(
                                                onTap: () {
                                                  !read.isShopFavorite(shop)
                                                      ? read
                                                          .addToFavorites(shop)
                                                      : read
                                                          .removeFromFavorites(
                                                              shop);
                                                  context.pop();
                                                },
                                                child: CustomIconTextRow(
                                                    fontSize: w * 0.04,
                                                    iconColor: AppColors
                                                        .mainBlackColor,
                                                    icon: Icons.star,
                                                    text: !read.isShopFavorite(
                                                            shop)
                                                        ? 'Add to favorites'
                                                        : 'Remove From Favorites'),
                                              ),
                                            );
                                          },
                                        ),
                                        BlocBuilder<FollowingCubit,
                                            FollowingState>(
                                          builder: (context, state) {
                                            return InkWell(
                                              onTap: () {
                                                !followingCubit
                                                        .getShopFollowingState(
                                                            shop)
                                                    ? {
                                                        context
                                                            .read<
                                                                ShopFollwersCounterCubit>()
                                                            .incrementFollowers(
                                                                shop),
                                                        followingCubit
                                                            .follow(shop),
                                                      }
                                                    : {
                                                        context
                                                            .read<
                                                                ShopFollwersCounterCubit>()
                                                            .decrementFollowers(
                                                                shop),
                                                        followingCubit
                                                            .unFollow(shop),
                                                      };
                                                context.pop();
                                              },
                                              child: CustomIconTextRow(
                                                  fontSize: w * 0.04,
                                                  iconColor:
                                                      AppColors.mainBlackColor,
                                                  icon: Icons
                                                      .person_add_alt_1_rounded,
                                                  text: followingCubit
                                                          .getShopFollowingState(
                                                              shop)
                                                      ? 'UnFollow ${shop.shopName}'
                                                      : 'Follow  ${shop.shopName}'),
                                            );
                                          },
                                        )
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
                  BlocBuilder<RateShopCubit, RateShopState>(
                    builder: (context, state) {
                      return CustomRate(
                        store: shop,
                      );
                    },
                  ),

                  // CustomText(
                  //   text: 'category',
                  //   fontSize: w * 0.035,
                  // ),
                  // 20.px,
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, size: w * 0.04)),

                  CustomText(
                    text: shop.location,
                    fontSize: w * 0.035,
                  ),
                  // 20.px,
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
                                              text: shop.shopCategory,
                                              textColor:
                                                  AppColors.secondaryFontColor,
                                            ),
                                            10.ph,
                                            CustomText(
                                              text: shop.shopCategory,
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
