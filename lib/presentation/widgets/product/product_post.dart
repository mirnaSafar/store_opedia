import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/logic/cubites/post/cubit/toggle_post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/delete_post_cubit.dart';
import 'package:shopesapp/logic/cubites/post/post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/pages/edit_post.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/product/product_info.dart';

import '../../shared/custom_widgets/custom_text.dart';

// ignore: must_be_immutable
class ProductPost extends StatefulWidget {
  final dynamic post;
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
    final size = MediaQuery.of(context).size;
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
                          onTap: () => context
                              .push(EditPostPage(
                                post: widget.post,
                              ))
                              .then((value) => context.pop()),
                          child: CustomIconTextRow(
                              fontSize: w * 0.04,
                              iconColor: AppColors.mainBlackColor,
                              svgIcon: 'edit-svgrepo-com',
                              // icon: Icons.edit,
                              text: 'Edit Post'),
                        ),
                        30.ph,
                        BlocProvider(
                          create: (context) => DeletePostCubit(),
                          child: BlocConsumer<DeletePostCubit, DeletePostState>(
                            listener: (context, state) {
                              if (state is DeletePostFailed) {
                                CustomToast.showMessage(
                                    size: size,
                                    message: state.message,
                                    context: context,
                                    messageType: MessageType.REJECTED);
                                setState(() {});
                                context.pop();
                              } else if (state is DeletePostSucceed) {
                                CustomToast.showMessage(
                                    size: size,
                                    message:
                                        'post has been deleted successfully',
                                    context: context,
                                    messageType: MessageType.SUCCESS);
                                setState(() {});
                                context.pop();
                              }
                            },
                            builder: (context, state) {
                              if (state is DeletePostProgress) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return InkWell(
                                onTap: () =>
                                    BlocProvider.of<DeletePostCubit>(context)
                                        .deletePost(
                                  postID: widget.post.postID,
                                  ownerID:
                                      globalSharedPreference.getString("ID")!,
                                  shopID: globalSharedPreference
                                      .getString("shopID")!,
                                ),
                                child: CustomIconTextRow(
                                    fontSize: w * 0.04,
                                    iconColor: AppColors.mainBlackColor,
                                    svgIcon: 'delete-svgrepo-com',
                                    // icon: Icons.delete,
                                    text: 'Delete Post'),
                              );
                            },
                          ),
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
                      CustomText(
                        text: globalSharedPreference.getString('shopName')!,
                      ),
                      CustomText(
                        text: widget.post.category ??
                            globalSharedPreference.getString("shopCategory")!,
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
          child: widget.post.photos != 'url'
              ? Image.network(widget.post.photos)
              : Image.asset('assets/images.jpg'),
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
                  /* 5.ph,
                  BlocBuilder<RatePostCubit, RatePostState>(
                    builder: (context, state) {
                      return CustomRate(
                        post: widget.post,
                      );
                    },
                  ),*/
                ],
              ),
              // 190.px,
              Row(
                children: [
                  BlocBuilder<TogglePostFavoriteCubit, TogglePostFavoriteState>(
                    builder: (context, state) {
                      PostFavoriteCubit postFavorite =
                          context.read<PostFavoriteCubit>();
                      return IconButton(
                          onPressed: () {
                            postFavorite.isPostFavorite(widget.post)
                                ? postFavorite.removeFromFavorites(widget.post)
                                : postFavorite.addToFavorites(widget.post);
                            context
                                .read<TogglePostFavoriteCubit>()
                                .toggolePostFavorite(
                                    postID: widget.post.postID,
                                    userID: globalSharedPreference
                                        .getString("ID")!);
                          },
                          icon: !postFavorite.isPostFavorite(widget.post)
                              ? const Icon(Icons.favorite_border_outlined)
                              : Icon(
                                  Icons.favorite,
                                  color: AppColors.mainRedColor,
                                ));
                    },
                  ),
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
