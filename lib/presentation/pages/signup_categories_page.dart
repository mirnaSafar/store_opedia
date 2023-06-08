import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

class SignUpCategoriesPage extends StatefulWidget {
  const SignUpCategoriesPage({Key? key}) : super(key: key);

  @override
  State<SignUpCategoriesPage> createState() => _SignUpCategoriesPageState();
}

class _SignUpCategoriesPageState extends State<SignUpCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainWhiteColor,
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Select a category',
                        fontSize: 24,
                        textColor: AppColors.mainTextColor,
                      ),
                      CustomText(
                        text: 'Done',
                        textColor: AppColors.mainBlueColor,
                      ),
                    ]),
              ),
              SizedBox(
                width: size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipPath(
                          clipper: myClipper(),
                          child: Container(
                            color: AppColors.mainOrangeColor,
                            width: 100,
                            height: size.height,
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.04),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 10,
                        separatorBuilder: (BuildContext context, int index) {
                          return const CustomDivider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 80, top: 0),
                                  child: Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.mainTextColor,
                                            offset: const Offset(0, 2),
                                            blurRadius: 8)
                                      ],
                                      color: AppColors.mainWhiteColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.032,
                                          horizontal: size.height * 0.05),
                                      child: CustomText(
                                        text: 'cate',
                                        bold: true,
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.005,
                                left: size.width * 0.07,
                                child: CircleAvatar(
                                  maxRadius: 37,
                                  backgroundColor: AppColors.mainBlackColor,
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.025,
                                right: size.width * 0.05,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColors.mainOrangeColor,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.mainTextColor,
                                              offset: const Offset(0, 2),
                                              blurRadius: 8)
                                        ],
                                        color: AppColors.mainWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(100, 0);
    path.quadraticBezierTo(130, 10, 140, 20);
    path.lineTo(100, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
