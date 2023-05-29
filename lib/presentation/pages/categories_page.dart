import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/shared/fonts.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // CategoriesScroller categoriesScroller = const CategoriesScroller();
  List<Widget> itemList = [];

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  void getCategoriesData() {
    List<dynamic> responseList = [
      {'name': 'fast food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
      {'name': 'sea food'},
    ];
    List<Widget> listItems = [];
    for (var element in responseList) {
      listItems.add(Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: AppColors.mainWhiteColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.mainBlackColor.withAlpha(100),
                  blurRadius: 10)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: element['name'],
                  fontSize: 25,
                  bold: true,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => context.push(const ControlPage()),
                      child: CustomText(
                        text: 'Done',
                        textColor: AppColors.mainBlueColor,
                        bold: true,
                      ),
                    ),
                    30.px,
                    InkWell(
                      child: CustomText(
                        text: 'Sub-categories',
                        textColor: AppColors.mainBlueColor,
                        bold: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Image.asset(
              'assets/verified.png',
              height: double.infinity,
              width: 100,
            ),
          ]),
        ),
      ));
    }
    setState(() {
      itemList = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoriesData();
    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    Widget categoriesScroller() {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    getCategoriesData;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.mainOrangeColor),
                    width: w * 0.4,
                    // margin: const EdgeInsets.only(right: 20),
                    height: h * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            CustomText(
                              text: 'Food',
                              fontSize: AppFonts.primaryFontSize,
                              textColor: AppColors.mainWhiteColor,
                            ),
                            10.ph,
                            CustomText(
                              text: '20 items',
                              fontSize: AppFonts.secondaryFontSize,
                              textColor: AppColors.mainWhiteColor,
                            )
                          ]),
                    ),
                  ),
                ),
                20.px,
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.mainOrangeColor),
                  width: w * 0.4,
                  margin: const EdgeInsets.only(right: 20),
                  height: h * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          CustomText(
                            text: 'Food',
                            fontSize: AppFonts.primaryFontSize,
                            textColor: AppColors.mainWhiteColor,
                          ),
                          10.ph,
                          CustomText(
                            text: '20 items',
                            fontSize: AppFonts.secondaryFontSize,
                            textColor: AppColors.mainWhiteColor,
                          )
                        ]),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.mainOrangeColor),
                  width: w * 0.4,
                  margin: const EdgeInsets.only(right: 30),
                  height: h * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          CustomText(
                            text: 'Food',
                            fontSize: AppFonts.primaryFontSize,
                            textColor: AppColors.mainWhiteColor,
                          ),
                          10.ph,
                          CustomText(
                            text: '20 items',
                            fontSize: AppFonts.secondaryFontSize,
                            textColor: AppColors.mainWhiteColor,
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainWhiteColor,
        ),
        body: SizedBox(
          height: h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: w * 0.15),
                child: CustomText(
                  text: 'Main Categories',
                  textColor: AppColors.secondaryFontColor,
                  bold: true,
                  fontSize: w * 0.05,
                ),
              ),
              30.ph,
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: w,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : h * 0.2,
                    child: categoriesScroller()),
              ),
              30.ph,
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.5 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..scale(scale, scale),
                        child: Align(
                            heightFactor: 0.7,
                            alignment: Alignment.topCenter,
                            child: itemList[index]),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
