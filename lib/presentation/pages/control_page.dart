import 'package:flutter/material.dart';

import 'package:shopesapp/presentation/pages/settings.dart';
import 'package:shopesapp/presentation/pages/store_page.dart';
import 'package:shopesapp/presentation/pages/home_page.dart';
import 'package:shopesapp/presentation/pages/suggested_stores.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../data/enums/bottom_navigation.dart';
import 'favourite_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  BottomNavigationEnum selected = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        // top: false,
        child: Scaffold(
      backgroundColor: AppColors.mainWhiteColor,
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarWidget(
          bottomNavigationEnum: selected,
          onTap: (selectedEnum, pageNumber) {
            controller.animateToPage(pageNumber,
                curve: Curves.easeInCirc,
                duration: const Duration(milliseconds: 100));
            setState(() {
              selected = selectedEnum;
              print(selected);
              print(pageNumber);
            });
          }),

      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {},
        children: const [
          SettingsPage(),
          SuggestedStoresView(),
          HomePage(),
          FavouritePage(),
          StorePage(),
        ],
      ),
      // /_screenList[_selectedindex],
    ));
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.0, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 1, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
