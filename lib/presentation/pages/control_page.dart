import 'package:flutter/material.dart';

import 'package:shopesapp/presentation/pages/settings.dart';
import 'package:shopesapp/presentation/pages/store_page.dart';
import 'package:shopesapp/presentation/pages/home_page.dart';
import 'package:shopesapp/presentation/pages/suggested_stores.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../data/enums/bottom_navigation.dart';
import 'demo_page.dart';
import 'favourite_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

int _selectedindex = 2;

final _screenList = [
  const SettingsPage(),
  const StorePage(),
  const HomePage(),
  const FavouritePage(),
  const DemoPage(),
];

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
    )
        // Stack(
        //   children: [
        //     Positioned(
        //         bottom: 0,
        //         left: 0,
        //         child: SizedBox(
        //           width: size.width,
        //           height: 70.0,
        //           child: Stack(
        //             children: [
        //               CustomPaint(
        //                 size: Size(size.width, 70),
        //                 painter: BNBCustomPainter(),
        //               ),
        //               Center(
        //                 heightFactor: 0.5,
        //                 child: SizedBox(
        //                   width: 60,
        //                   height: 60,
        //                   child: FittedBox(
        //                     child: FloatingActionButton(
        //                       backgroundColor:
        //                           Theme.of(context).colorScheme.primary,
        //                       onPressed: () {
        //                         setState(() {
        //                           _selectedindex = 2;
        //                         });
        //                       },
        //                       child: const Icon(
        //                         Icons.home,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: [
        //                   IconButton(
        //                       onPressed: () {
        //                         setState(() {
        //                           _selectedindex = 0;
        //                         });
        //                       },
        //                       icon: Icon(
        //                         Icons.settings,
        //                         color: _selectedindex == 0
        //                             ? Colors.black
        //                             : Colors.grey,
        //                       )),
        //                   IconButton(
        //                       onPressed: () {
        //                         setState(() {
        //                           _selectedindex = 1;
        //                         });
        //                       },
        //                       icon: Icon(
        //                         Icons.store,
        //                         color: _selectedindex == 1
        //                             ? Colors.black
        //                             : Colors.grey,
        //                       )),
        //                   Container(
        //                     width: size.width * 0.20,
        //                   ),
        //                   IconButton(
        //                       onPressed: () {
        //                         setState(() {
        //                           _selectedindex = 3;
        //                         });
        //                       },
        //                       icon: Icon(
        //                         Icons.favorite,
        //                         color: _selectedindex == 3
        //                             ? Colors.black
        //                             : Colors.grey,
        //                       )),
        //                   IconButton(
        //                       onPressed: () {
        //                         setState(() {
        //                           _selectedindex = 4;
        //                         });
        //                       },
        //                       icon: Icon(
        //                         Icons.person,
        //                         color: _selectedindex == 4
        //                             ? Colors.black
        //                             : Colors.grey,
        //                       )),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ))
        //   ],
        // )),
        );
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
