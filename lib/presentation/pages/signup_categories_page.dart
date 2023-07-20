import 'package:flutter/material.dart';
import 'package:shopesapp/constant/categories.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class SignUpCategoriesPage extends StatefulWidget {
  const SignUpCategoriesPage({Key? key}) : super(key: key);

  @override
  State<SignUpCategoriesPage> createState() => _SignUpCategoriesPageState();
}

class _SignUpCategoriesPageState extends State<SignUpCategoriesPage> {
  String selectedCategory = '';

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
                      InkWell(
                        onTap: () {
                          context.pop(selectedCategory);
                        },
                        child: CustomText(
                          text: 'Done',
                          textColor: AppColors.mainBlueColor,
                        ),
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
                        itemCount: categories.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const CustomDivider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = categories[index];
                                  });
                                },
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
                                        text: categories[index],
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
                                  backgroundImage:
                                      const AssetImage('assets/images.jpg'),
                                ),
                              ),
                              Positioned(
                                top: size.height * 0.025,
                                right: size.width * 0.05,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = categories[index] +
                                          '/' +
                                          categories[index];
                                    });
                                  },
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
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0000167);
    path_0.quadraticBezierTo(size.width * 0.0336500, size.height * 0.0013333,
        size.width * 0.1274000, size.height * 0.0013333);
    path_0.cubicTo(
        size.width * 0.3117250,
        size.height * 0.0025000,
        size.width * 0.3129000,
        size.height * 0.1353500,
        size.width * 0.3125000,
        size.height * 0.1640833);
    path_0.cubicTo(
        size.width * 0.3106500,
        size.height * 0.2454667,
        size.width * 0.3120750,
        size.height * 0.6289167,
        size.width * 0.3125000,
        size.height * 0.8363333);
    path_0.cubicTo(
        size.width * 0.3051000,
        size.height * 0.9176000,
        size.width * 0.2441000,
        size.height * 0.9980667,
        size.width * 0.1197500,
        size.height * 0.9991667);
    path_0.quadraticBezierTo(size.width * 0.0254000, size.height * 0.9990333,
        size.width * -0.0008500, size.height * 0.9994500);
    path_0.lineTo(0, size.height * 0.0000167);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
