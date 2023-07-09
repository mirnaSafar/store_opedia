import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/logic/cubites/post/delete_post_cubit.dart';
import 'package:shopesapp/logic/cubites/post/post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/pages/edit_post.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/product/product_info.dart';

import '../../shared/custom_widgets/custom_text.dart';

class ProductPost extends StatefulWidget {
  final Post post;
  bool? profileDisplay;
  ProductPost({Key? key, required this.post, this.profileDisplay = false})
      : super(key: key);

  @override
  State<ProductPost> createState() => _ProductPostState();
}

class _ProductPostState extends State<ProductPost> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    Future postOptionsDialog() {
      return showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) {
            return Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(w * 0.1),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => context.push(const EditPostPage()),
                          child: CustomIconTextRow(
                              fontSize: w * 0.04,
                              iconColor: AppColors.mainBlackColor,
                              icon: Icons.edit,
                              text: 'Edit Post'),
                        ),
                        30.ph,
                        InkWell(
                          onTap: () => BlocProvider.of<DeletePostCubit>(context)
                              .deletePost(
                            postID: widget.post.postID,
                            ownerID: globalSharedPreference.getString("ID")!,
                            shopID: globalSharedPreference.getString("shopID")!,
                          ),
                          child: CustomIconTextRow(
                              fontSize: w * 0.04,
                              iconColor: AppColors.mainBlackColor,
                              icon: Icons.delete,
                              text: 'Delete Post'),
                        ),
                      ]),
                ),
              ],
            );
          });
    }

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
                      const CustomText(text: 'widget.post.shopeID'),
                      CustomText(
                        text: widget.post.category,
                        fontSize: w * 0.03,
                        textColor: AppColors.mainTextColor,
                      ),
                    ],
                  )
                ],
              ),
//test if the post
              // 190.px,
              IconButton(
                  onPressed: () =>
                      widget.profileDisplay! ? postOptionsDialog() : null,
                  icon: !widget.profileDisplay!
                      ? const Icon(Icons.location_on_outlined)
                      : const Icon(Icons.edit))
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
                  CustomText(text: widget.post.title),
                  5.ph,
                  BlocBuilder<RatePostCubit, RatePostState>(
                    builder: (context, state) {
                      return CustomRate(
                        post: widget.post,
                      );
                    },
                  ),
                ],
              ),
              // 190.px,
              Row(
                children: [
                  // BlocBuilder<PostFavoriteCubit, PostFavoriteState>(
                  //   builder: (context, state) {
                  //     final postFavorite = context.read<PostFavoriteCubit>();

                  BlocBuilder<PostFavoriteCubit, PostFavoriteState>(
                    builder: (context, state) {
                      PostFavoriteCubit postFavorite =
                          context.read<PostFavoriteCubit>();
                      return IconButton(
                          onPressed: () {
                            postFavorite.isPostFavorite(widget.post)
                                ? postFavorite.removeFromFavorites(widget.post)
                                : postFavorite.addToFavorites(widget.post);
                          },
                          icon: !postFavorite.isPostFavorite(widget.post)
                              ? const Icon(Icons.favorite_border_outlined)
                              : Icon(
                                  Icons.favorite,
                                  color: AppColors.mainRedColor,
                                ));
                    },
                  ),
                  // : Icon(
                  //     Icons.favorite,
                  //     color: AppColors.mainRedColor,
                  //   ));
                  // },
                  // ),
                  10.px,
                  InkWell(
                      onTap: () => context.push(ProductInfo(
                            post: widget.post,
                          )),
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
