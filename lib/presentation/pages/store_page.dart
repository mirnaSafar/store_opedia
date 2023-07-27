import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/logic/cubites/post/posts_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/toggole_follow_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/get_owner_shops_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/shop_follwers_counter_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/presentation/pages/add_post/add_post_page.dart';
import 'package:shopesapp/presentation/pages/edit_store.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopesapp/presentation/widgets/dialogs/awosem_dialog.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/error.dart';

import '../../main.dart';
import '../widgets/dialogs/browsing_alert_dialog.dart';
import '../widgets/home/no_posts_yet.dart';

// ignore: must_be_immutable
class StorePage extends StatefulWidget {
  StorePage({
    Key? key,
    this.shop,
    this.profileDisplay,
  }) : super(key: key);
  Shop? shop;
  bool? profileDisplay;
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  void updateStoreState() {
    // widget.shop!.followesNumber =
    //     globalSharedPreference.getInt("followesNumber");

    setState(() {});
  }

  // late UserOwnerCubit userOwnerCubit = context.read<UserOwnerCubit>();
  List<dynamic> postsList = [];
  List<dynamic> ownerShpos = [];

  // String? currentID;
  //bool isLastShop = false;

  /* @override
  void initState() {
    if (ownerShpos.isEmpty) {}
    if (postsList.isEmpty) {
      context.read<PostsCubit>().getOwnerPosts(
          ownerID: globalSharedPreference.getString('ID')!,
          shopID: globalSharedPreference.getString('shopID')!);
    }
    currentID = context.read<SwitchShopCubit>().getStoredShopID();

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    List<String> splitStartTime = widget.shop!.startWorkTime.split(":");
    String startWorkTime = splitStartTime[0] + ":" + splitStartTime[1];
    List<String> splitEndWorkTime = widget.shop!.endWorkTime.split(":");
    String endtWorkTime = splitEndWorkTime[0] + ":" + splitEndWorkTime[1];

    var size = MediaQuery.of(context).size;
    // updateTheSta
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.mainWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsetsDirectional.only(start: w * 0.06, end: w * 0.01),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        // alignment: AlignmentDirectional.topCenter,
                        children: [
                          SizedBox(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(w * 0.05),
                                child: widget.shop!.shopCoverImage != 'url'
                                    ? Image.file(
                                        File(widget.shop!.shopCoverImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : globalSharedPreference
                                                .getString("shopCoverImage") !=
                                            'url'
                                        ? Image.file(
                                            File(globalSharedPreference
                                                .getString("shopCoverImage")!),
                                            fit: BoxFit.contain,
                                          )
                                        : const Image(
                                            image: AssetImage(
                                                'assets/store_cover_placeholder.jpg'))),
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
                                          backgroundColor:
                                              AppColors.mainTextColor,
                                          backgroundImage: FileImage(File(widget
                                                  .shop!.shopProfileImage ??
                                              globalSharedPreference.getString(
                                                  "shopProfileImage") ??
                                              '')),
                                          child: widget.shop!
                                                          .shopProfileImage ==
                                                      'url' &&
                                                  globalSharedPreference.getString(
                                                          "shopProfileImage") ==
                                                      'url'
                                              ? ClipOval(
                                                  child: Image.asset(
                                                    'assets/store_placeholder.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : null),
                                    ),
                                    BlocBuilder<WorkTimeCubit, WorkTimeState>(
                                      builder: (context, state) {
                                        return Visibility(
                                          visible: state.isOpen == true &&
                                              widget.shop?.isActive == true,
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
                                                    backgroundColor:
                                                        Colors.green,
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
                                    BlocBuilder<WorkTimeCubit, WorkTimeState>(
                                      builder: (context, state) {
                                        return Visibility(
                                          visible: state.isOpen != true &&
                                              widget.shop?.isActive == true,
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
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ),
                                                2.px,
                                                CustomText(
                                                  text: 'Close now',
                                                  textColor: Colors.red,
                                                  fontSize: w * 0.03,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Visibility(
                                      visible: widget.shop?.isActive == false,
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
                                                backgroundColor:
                                                    Colors.blueGrey,
                                              ),
                                            ),
                                            2.px,
                                            CustomText(
                                              text: 'Deactivated Now',
                                              textColor: Colors.blueGrey,
                                              fontSize: w * 0.03,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: w * 0.01),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: widget.shop!.shopName,
                                        bold: true,
                                        fontSize: w * 0.05,
                                        textColor:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      10.px,
                                      BlocBuilder<RateShopCubit, RateShopState>(
                                        builder: (context, state) {
                                          return CustomRate(
                                            store: widget.shop!,
                                            enableRate: true,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      10.ph,
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          CustomPaint(
                              painter: profilePainter(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: w,
                                ),
                                child: SizedBox(
                                  width: w / 4,
                                  height: h * 0.5,
                                ),
                              )),
                          // FloatingActionButton(
                          //     onPressed: () {
                          //       context.push(const EditStore());
                          //     },
                          //     backgroundColor: AppColors.mainOrangeColor,
                          //     child: const svgIcon(Icons.edit)),
                          Visibility(
                              visible: widget.profileDisplay ?? false,
                              child: Positioned(
                                  right: w * 0.06,
                                  bottom: w * 0,
                                  child: _getFAB())),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              0.ph,
                              Row(
                                children: [
                                  Icon(
                                    Icons.tag,
                                    color: Colors.grey.shade300,
                                  ),
                                  10.px,
                                  CustomText(
                                    text: widget.shop!.shopCategory,
                                    // fontSize: 18,
                                    textColor: AppColors.secondaryFontColor,
                                  ),
                                ],
                              ),
                              15.ph,
                              CustomText(
                                  textColor: Theme.of(context).primaryColorDark,
                                  fontSize: 15,
                                  text: widget.shop!.shopDescription ??
                                      'basic description about the \nstore and its major'),
                              20.ph,
                              Row(
                                children: [
                                  BlocBuilder<ShopFollwersCounterCubit,
                                      ShopFollwersCounterState>(
                                    builder: (context, state) {
                                      return CustomText(
                                        text:
                                            '${context.read<ShopFollwersCounterCubit>().getShopFollwersCount(widget.shop!)} Followers',
                                        textColor: AppColors.mainBlueColor,
                                      );
                                    },
                                  ),
                                  70.px,
                                  BlocBuilder<FollowingCubit, FollowingState>(
                                    builder: (context, state) {
                                      var followingCubit =
                                          context.read<FollowingCubit>();
                                      var shop = SharedPreferencesRepository
                                              .getSavedShop(widget.shop!) ??
                                          widget.shop!;
                                      return InkWell(
                                        onTap: () {
                                          if (!SharedPreferencesRepository
                                              .getBrowsingPostsMode()) {
                                            !followingCubit
                                                    .getShopFollowingState(shop)
                                                ? {
                                                    context
                                                        .read<
                                                            ShopFollwersCounterCubit>()
                                                        .incrementFollowers(
                                                            shop),
                                                    followingCubit.follow(shop),
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
                                            BlocProvider.of<
                                                        ToggoleFollowShopCubit>(
                                                    context)
                                                .toggoleFolowShop(
                                                    shopID: widget.shop!.shopID,
                                                    ownerID:
                                                        widget.shop!.ownerID);
                                          } else {
                                            showBrowsingDialogAlert(context);
                                          }
                                        },
                                        child: CustomText(
                                          text: followingCubit
                                                  .getShopFollowingState(shop)
                                              ? 'Following'
                                              : 'Follow',
                                          textColor: AppColors.mainBlueColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              CustomIconTextRow(
                                  textColor: Theme.of(context).primaryColorDark,
                                  svgIcon: 'clock-square-svgrepo-com',
                                  // svgIcon: Icons.alarm,
                                  text: widget.shop!.isActive == true
                                      ? '$startWorkTime - $endtWorkTime'
                                      : "---  - ---"),
                              20.ph,
                              // CustomIconTextRow(
                              //     textColor: Theme.of(context).primaryColorDark,
                              //     svgIcon: Icons.phone,
                              //     text:
                              //         "Owner PhoneNumber : ${widget.shop!.ownerPhoneNumber}"),
                              // 20.ph,
                              Visibility(
                                visible: widget.shop!.shopPhoneNumber != null,
                                child: Column(
                                  children: [
                                    CustomIconTextRow(
                                        textColor:
                                            Theme.of(context).primaryColorDark,
                                        svgIcon: 'phone-svgrepo-com',
                                        text: widget.shop!.isActive == true
                                            ? "${widget.shop!.shopPhoneNumber}"
                                            : "------------"),
                                    20.ph,
                                  ],
                                ),
                              ),
                              CustomIconTextRow(
                                  textColor: Theme.of(context).primaryColorDark,
                                  // svgIcon: Icons.email,
                                  svgIcon: 'mail-svgrepo-com',
                                  text: widget.shop!.ownerEmail),
                              20.ph,
                              CustomIconTextRow(
                                  textColor: Theme.of(context).primaryColorDark,
                                  svgIcon: 'map-point-wave-svgrepo-com',
                                  text: widget.shop!.location),
                              const CustomDivider(),
                              Visibility(
                                visible: widget.shop!.socialUrl!.isNotEmpty &&
                                    (widget.shop!.socialUrl![0].length != 0 ||
                                        widget.shop!.socialUrl![1].length != 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Social accounts',
                                      textColor:
                                          Theme.of(context).primaryColorDark,
                                      fontSize: w * 0.04,
                                      bold: true,
                                    ),
                                    30.ph,
                                    Visibility(
                                      visible: widget
                                              .shop!.socialUrl!.isNotEmpty &&
                                          widget.shop!.socialUrl![0].length !=
                                              0,
                                      child: CustomIconTextRow(
                                          textColor: Theme.of(context)
                                              .primaryColorDark,
                                          svgIcon:
                                              'instagram-2-1-logo-svgrepo-com',
                                          text:
                                              widget.shop!.socialUrl!.isNotEmpty
                                                  ? widget.shop!.socialUrl![0]
                                                  : ''),
                                    ),
                                    20.ph,
                                    Visibility(
                                      visible: widget
                                              .shop!.socialUrl!.isNotEmpty &&
                                          widget.shop!.socialUrl![1].length !=
                                              0,
                                      child: CustomIconTextRow(
                                          textColor: Theme.of(context)
                                              .primaryColorDark,
                                          svgIcon:
                                              'facebook-3-logo-svgrepo-com',
                                          text:
                                              widget.shop!.socialUrl!.isNotEmpty
                                                  ? widget.shop!.socialUrl![1]
                                                  : ''),
                                    ),
                                    Visibility(
                                        visible: ownerShpos.isNotEmpty,
                                        child: const CustomDivider()),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: ownerShpos.isNotEmpty,
                                child: CustomText(
                                  text: 'Related Stores',
                                  textColor: Theme.of(context).primaryColorDark,
                                  fontSize: w * 0.04,
                                  bold: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
              Visibility(
                visible: ownerShpos.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    20.ph,
                    SizedBox(
                      height: h / 6,
                      child:
                          BlocConsumer<GetOwnerShopsCubit, GetOwnerShopsState>(
                        listener: (context, state) {
                          if (state is GetOwnerShopsFiled) {
                            buildAwsomeDialog(context, "Failed",
                                    state.message.toUpperCase(), "OK",
                                    type: DialogType.ERROR)
                                .show();
                          } else if (state is GetOwnerShopsSucceed) {}
                        },
                        builder: (context, state) {
                          if (state is GetOwnerShopsProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetOwnerShopsSucceed) {
                            ownerShpos =
                                BlocProvider.of<GetOwnerShopsCubit>(context)
                                    .ownerShops;

                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.only(start: w * 0.04),
                              child: ListView.separated(
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: ownerShpos.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 20.px;
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  if (ownerShpos[index]['shopID'] !=
                                      widget.shop!.shopID) {
                                    return Column(
                                      children: [
                                        CircleAvatar(
                                            radius: w * 0.12,
                                            backgroundColor:
                                                AppColors.mainTextColor,
                                            backgroundImage: FileImage(File(
                                                ownerShpos[index][
                                                            "shopProfileImage"] !=
                                                        'url'
                                                    ? ownerShpos[index]
                                                        ["shopProfileImage"]
                                                    : '')),
                                            child: ownerShpos[index]
                                                        ["shopProfileImage"] ==
                                                    'url'
                                                ? ClipOval(
                                                    child: Image.asset(
                                                      'assets/store_placeholder.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : null),
                                        5.ph,
                                        CustomText(
                                          text: ownerShpos[index]['shopName'],
                                          textColor: Theme.of(context)
                                              .primaryColorDark,
                                        )
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            );
                          }
                          return buildError(size);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Visibility(child: CustomDivider()),
              BlocConsumer<PostsCubit, PostsState>(
                listener: (context, state) {
                  if (state is ErrorFetchingPosts) {
                    buildAwsomeDialog(context, "Failed",
                            state.message.toUpperCase(), "OK",
                            type: DialogType.ERROR)
                        .show();
                  } else if (state is PostsFetchedSuccessfully) {}
                },
                builder: (context, state) {
                  if (state is FeatchingPostsProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NoPostsYet) {
                    return Center(child: buildNoPostsYet(size, "No Posts Yet"));
                  } else if (state is PostsFetchedSuccessfully) {
                    postsList = BlocProvider.of<PostsCubit>(context).ownerPosts;

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: postsList.length,
                      separatorBuilder: (context, index) =>
                          const CustomDivider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductPost(
                          post: postsList[index],
                          profileDisplay: widget.profileDisplay ?? false,
                        );
                      },
                    );
                  }
                  return buildError(size);
                },
              ),
            ],
          ),
        ));
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme:
          IconThemeData(size: 22, color: AppColors.mainWhiteColor),
      backgroundColor: AppColors.mainOrangeColor,
      visible: true,
      curve: Curves.easeIn,
      childMargin: const EdgeInsets.only(bottom: 30),
      spacing: 10,
      spaceBetweenChildren: 5,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.add),
            onTap: () {
              context.push(const AddPostPage());
            },
            label: 'Add new post',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.mainWhiteColor,
              fontSize: 16,
            ),
            labelBackgroundColor: AppColors.mainOrangeColor),
        SpeedDialChild(
          child: const Icon(Icons.edit),
          onTap: () {
            context.push(EditStore(function: updateStoreState));
            // setState(() {});
          },
          label: 'Edit store information',
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.mainWhiteColor,
            fontSize: 16,
          ),
          labelBackgroundColor: AppColors.mainOrangeColor,
        )
      ],
    );
  }
}

// ignore: camel_case_types
class profilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blueGrey.shade200,
          // Colors.blueGrey.shade50,
          AppColors.mainWhiteColor,
        ],
      ).createShader(rect);
    Path path0 = Path();
    path0.moveTo(size.width * 0.6200000, 0);
    path0.quadraticBezierTo(size.width * 0.9050000, 0, size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 0.7168750, size.height,
        size.width * 0.6225000, size.height);
    path0.cubicTo(
        size.width * 0.6593750,
        size.height * 0.8975000,
        size.width * 0.7000000,
        size.height * 0.6305000,
        size.width * 0.7000000,
        size.height * 0.4980000);
    path0.cubicTo(
        size.width * 0.6968750,
        size.height * 0.3665000,
        size.width * 0.6375000,
        size.height * 0.0155000,
        size.width * 0.6200000,
        0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
