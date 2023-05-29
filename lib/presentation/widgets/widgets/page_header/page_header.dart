import 'package:flutter/material.dart';
import 'package:shopesapp/constant/cities.dart';
import 'package:shopesapp/presentation/pages/categories_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_sort_row.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/user_input.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    Widget sortDialog() {
      return Dialog(
        alignment: Alignment.topLeft,
        insetPadding: EdgeInsets.only(top: h * 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            30.ph,
            const CustomSortRow(
                title: 'Location',
                subtitle: 'Nearest stores will be seen first',
                icon: Icons.location_on_sharp),
            const CustomSortRow(
                title: 'Rate',
                subtitle: 'Most rated stores will be seen first',
                icon: Icons.star),
            const CustomSortRow(
              title: 'Oldest',
              subtitle: 'Oldest stores will be seen first',
            ),
            const CustomSortRow(
              title: 'Newest',
              subtitle: 'Newest stores will be seen first',
            ),
            30.ph
          ],
        ),
      );
    }

    Widget filterDialog() {
      return Dialog(
        alignment: Alignment.topLeft,
        insetPadding: EdgeInsets.only(top: h * 0.08),

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.ph,
              InkWell(
                  onTap: () {
                    context.push(const CategoriesPage());
                  },
                  child: CustomText(
                    text: 'click to Identify your request more specifically',
                    textColor: AppColors.secondaryFontColor,
                  )),
              10.ph,
              const CustomSortRow(
                  title: 'Location',
                  subtitle: 'Nearest stores will be seen first',
                  icon: Icons.location_on_sharp),
              const CustomSortRow(
                  title: 'Rate',
                  subtitle: 'Most rated stores will be seen first',
                  icon: Icons.star),
              const CustomSortRow(
                title: 'Oldest',
                subtitle: 'Oldest stores will be seen first',
              ),
              const CustomSortRow(
                title: 'Newest',
                subtitle: 'Newest stores will be seen first',
              ),
              30.ph
            ],
          ),
        ),
      );
    }

    Widget cityDialog() {
      return Dialog(
        alignment: Alignment.topRight,
        insetPadding: EdgeInsets.only(top: h * 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w / 2,
          height: h / 1.5,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: w * 0.03,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: w * 0.05),
                  child: CustomText(
                    text: 'Choose a city ',
                    bold: true,
                    textColor: AppColors.secondaryFontColor,
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cities.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: w * 0.06),
                        child: CustomText(text: cities[index]),
                      ),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return const CustomDivider();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    TextEditingController searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                InkWell(
                    onTap: () => showDialog(
                          context: context,
                          builder: (context) => filterDialog(),
                        ),
                    child: Icon(Icons.filter_list_outlined, size: w * 0.07)),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 240),
                  child: InkWell(
                      onTap: () => showDialog(
                            context: context,
                            builder: (context) => sortDialog(),
                          ),
                      child: Icon(Icons.sort, size: w * 0.07)),
                ),
                InkWell(
                    onTap: () => showDialog(
                          context: context,
                          builder: (context) => cityDialog(),
                        ),
                    child: Icon(Icons.location_city, size: w * 0.07)),
              ],
            ),
          ),
          UserInput(
            text: 'Search',
            prefixIcon: const Icon(Icons.search),
            controller: searchController,
          )
        ],
      ),
    );
  }
}
