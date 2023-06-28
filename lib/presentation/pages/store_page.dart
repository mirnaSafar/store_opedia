import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/presentation/pages/add_post_page.dart';
import 'package:shopesapp/presentation/pages/edit_store.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_icon_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custoum_rate.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import '../widgets/product/product_post.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    context.read<WorkTimeCubit>().testOpenTime();
    super.initState();
  }

  List<Post> postList = [];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      //  backgroundColor: AppColors.mainWhiteColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
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
                                padding:
                                    EdgeInsetsDirectional.only(start: w * 0.01),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: 'Store name',
                                      bold: true,
                                      fontSize: w * 0.05,
                                      textColor:
                                          Theme.of(context).primaryColorDark,
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
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CustomPaint(
                            painter: profilePainter(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: w,
                              ),
                              child: SizedBox(
                                width: w / 4,
                                height: h * 0.67,
                              ),
                            )),
                        // FloatingActionButton(
                        //     onPressed: () {
                        //       context.push(const EditStore());
                        //     },
                        //     backgroundColor: AppColors.mainOrangeColor,
                        //     child: const Icon(Icons.edit)),
                        Positioned(right: w * 0.06, child: _getFAB()),
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
                                  text: 'clothes',
                                  // fontSize: 18,
                                  textColor: AppColors.secondaryFontColor,
                                ),
                              ],
                            ),
                            15.ph,
                            CustomText(
                                textColor: Theme.of(context).primaryColorDark,
                                fontSize: 15,
                                text:
                                    'basic description about the \nstore and its major'),
                            20.ph,
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
                                      onTap: () =>
                                          state.followed = !state.followed,
                                      child: CustomText(
                                        text: state.followed
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
                                icon: Icons.alarm,
                                text: 'Work hours:   8am-2pm'),
                            20.ph,
                            CustomIconTextRow(
                                textColor: Theme.of(context).primaryColorDark,
                                icon: Icons.phone,
                                text: '0987655432'),
                            20.ph,
                            CustomIconTextRow(
                                textColor: Theme.of(context).primaryColorDark,
                                icon: Icons.email,
                                text: 'name@gmail.com'),
                            20.ph,
                            CustomIconTextRow(
                                textColor: Theme.of(context).primaryColorDark,
                                icon: Icons.location_on_outlined,
                                text: 'Hamah'),
                            const CustomDivider(),
                            CustomText(
                              text: 'Social accounts',
                              textColor: Theme.of(context).primaryColorDark,
                              fontSize: w * 0.04,
                              bold: true,
                            ),
                            20.ph,
                            CustomIconTextRow(
                                textColor: Theme.of(context).primaryColorDark,
                                icon: Icons.facebook,
                                text: 'https://instagram.com'),
                            10.ph,
                            CustomIconTextRow(
                                textColor: Theme.of(context).primaryColorDark,
                                icon: Icons.facebook,
                                text: 'https://instagram.com'),
                            const CustomDivider(),
                            CustomText(
                              text: 'Related Stores',
                              textColor: Theme.of(context).primaryColorDark,
                              fontSize: w * 0.04,
                              bold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
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
                          CustomText(
                            text: 'store name',
                            textColor: Theme.of(context).primaryColorDark,
                          )
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
              itemCount: 5,
              separatorBuilder: (context, index) => const CustomDivider(),
              itemBuilder: (BuildContext context, int index) {
                return const ProductPost();
              },
            ),
          ],
        ),
      ),
    );
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
            context.push(const EditStore());
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
