import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import 'package:shopesapp/logic/cubites/cubit/profile_cubit.dart';
import 'package:shopesapp/main.dart';

import 'package:shopesapp/presentation/pages/settings.dart';
import 'package:shopesapp/presentation/pages/store_page.dart';
import 'package:shopesapp/presentation/pages/home_page.dart';
import 'package:shopesapp/presentation/pages/suggested_stores.dart';
import 'package:shopesapp/presentation/pages/user_store.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../data/enums/bottom_navigation.dart';
import '../../logic/cubites/shop/work_time_cubit.dart';
import '../widgets/switch_shop/no_selected_store.dart';
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
    Owner user = Owner(
        name: 'name',
        email: 'email',
        phoneNumber: 'phoneNumber',
        id: '123',
        currentShop: Shop(
            shopCategory: 'shopCategory',
            location: 'location',
            startWorkTime: 'startWorkTime',
            endWorkTime: 'endWorkTime',
            ownerID: 'ownerID',
            ownerEmail: 'ownerEmail',
            ownerPhoneNumber: 'ownerPhoneNumber',
            shopID: 'shopID',
            shopName: 'shopName',
            ownerName: 'ownerName'),
        password: '');
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
            });
          }),

      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {},
        children: [
          const SettingsPage(),
          const SuggestedStoresView(),
          const HomePage(),
          const FavouritePage(),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is UserLoginedIn) {
                return const UserStore();
              }
              {
                context.read<WorkTimeCubit>().testOpenTime(
                    openTime:
                        globalSharedPreference.getString("startWorkTime")!,
                    closeTime:
                        globalSharedPreference.getString("endWorkTime")!);
                return StorePage(
                    shop: Shop(
                      shopCategory:
                          globalSharedPreference.getString("shopCategory")!,
                      location: globalSharedPreference.getString("location")!,
                      startWorkTime:
                          globalSharedPreference.getString("startWorkTime")!,
                      endWorkTime:
                          globalSharedPreference.getString("endWorkTime")!,
                      ownerID: globalSharedPreference.getString("ID")!,
                      ownerEmail: globalSharedPreference.getString("email")!,
                      ownerPhoneNumber:
                          globalSharedPreference.getString("phoneNumber")!,
                      shopID: globalSharedPreference.getString("shopID")!,
                      shopName: globalSharedPreference.getString("shopName")!,
                      ownerName: globalSharedPreference.getString("name")!,
                      followesNumber:
                          globalSharedPreference.getInt("followesNumber")!,
                      rate: globalSharedPreference.getInt("rate"),
                      shopCoverImage:
                          globalSharedPreference.getString("shopCoverImage"),
                      shopDescription:
                          globalSharedPreference.getString("shopDescription"),
                      shopPhoneNumber:
                          globalSharedPreference.getString("shopPhoneNumber"),
                      shopProfileImage:
                          globalSharedPreference.getString("shopProfileImage"),
                    ),
                    profileDisplay: true);
              }
            },
          ),
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
