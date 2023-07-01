import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/rate_shop_cubit.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

class CustomRate extends StatefulWidget {
  const CustomRate(
      {Key? key, this.size, this.enableRate = false, this.store, this.post})
      : super(key: key);
  final double? size;
  final bool? enableRate;
  final Shop? store;
  final Post? post;

  @override
  State<CustomRate> createState() => _CustomRateState();
}

class _CustomRateState extends State<CustomRate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final rateDialog = RatingDialog(
      initialRating: 1.0,
      title: const Text(''),
      message: Text(
        'Please Rate the ${widget.store != null ? 'store' : 'product'} if you tried it',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      submitButtonText: 'Submit',
      commentHint: 'you can leave your comment here',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        if (response.rating > 3.0) {
          widget.post == null
              ? context.read<RateShopCubit>().setShopRating(
                  newRate: response.rating,
                  ownerId: widget.store?.ownerID ?? '1',
                  shopId: widget.store?.shopID ?? '1')
              : context.read<RatePostCubit>().setPostRating(
                  newRate: response.rating,
                  ownerId: widget.post?.ownerID ?? '1',
                  shopId: widget.post?.shopeID ?? '1',
                  postId: widget.post!.postID);
        } else {}
      },
    );

    return Row(
      children: [
        InkWell(
          onTap: widget.enableRate!
              ? () {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        true, // set to false if you want to force a rating
                    builder: (context) => rateDialog,
                  );
                }
              : null,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.mainOrangeColor,
                size: widget.size ?? w * 0.03,
              ),
              BlocBuilder<RateShopCubit, RateShopState>(
                builder: (context, state) {
                  return BlocBuilder<RatePostCubit, RatePostState>(
                    builder: (context, state) {
                      return CustomText(
                        text: widget.post == null
                            ? context
                                .read<RateShopCubit>()
                                .getShopRating(
                                    ownerId: widget.store?.ownerID ?? '1',
                                    shopId: widget.store?.shopID ?? '1')
                                .toString()
                            : context
                                .read<RatePostCubit>()
                                .getPostRating(
                                  ownerId: widget.store?.ownerID ?? '1',
                                  shopId: widget.store?.shopID ?? '1',
                                  postId: widget.post!.postID,
                                )
                                .toString(),
                        textColor: AppColors.mainOrangeColor,
                        fontSize: widget.size ?? w * 0.03,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
