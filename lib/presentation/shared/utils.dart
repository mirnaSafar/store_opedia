import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopesapp/data/enums/file_type.dart';
import 'package:shopesapp/data/enums/message_type.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_toast.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/shop.dart';
import '../../data/repositories/shared_preferences_repository.dart';
import '../../logic/cubites/cubit/auth_cubit.dart';
import '../../logic/cubites/cubit/auth_state.dart';
import '../../logic/cubites/post/posts_cubit.dart';
import '../../logic/cubites/shop/get_owner_shops_cubit.dart';
import '../../logic/cubites/shop/work_time_cubit.dart';
import '../../main.dart';
import '../pages/favourite_page.dart';
import '../pages/home_page.dart';
import '../pages/settings.dart';
import '../pages/store_page.dart';
import '../pages/suggested_stores.dart';
import '../widgets/switch_shop/browsing_mode_profile.dart';
import '../widgets/switch_shop/no_selected_store.dart';

bool isEmail(String value) {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool validPassword(String password) {
  RegExp passExp =
      RegExp(r'^(?=.*[^a-zA-Z\d\s])(?=.*[a-zA-Z])[@$!%*?&a-zA-Z\d]{8,}$');
  return passExp.hasMatch(password);
}

bool isName(String name) {
  RegExp nameExp = RegExp(r'^[a-zA-Z\d\s]{2,15}$');
  return nameExp.hasMatch(name);
}

bool isMobileNumber(String num) {
  RegExp numExp = RegExp(r'^((\+|00)?(963)|0)?9[0-9]{8}$');
  return numExp.hasMatch(num);
}

class FileTypeModel {
  FileType type;
  String path;

  FileTypeModel(this.path, this.type);
}

Future cLaunchUrl(Uri url) async {
  if (await canLaunchUrl(url)) {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      CustomToast.showMessage(
          message: LocaleKeys.cant_lunch_url.tr(),
          messageType: MessageType.REJECTED,
          size: const Size(400, 100));
    }
  } else {
    CustomToast.showMessage(
        message: LocaleKeys.app_not_installed.tr(),
        messageType: MessageType.REJECTED,
        size: const Size(400, 100));
  }
}

void customLoader(Size size) =>
    BotToast.showCustomLoading(toastBuilder: (context) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.mainBlackColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: size.width / 4,
        height: size.width / 4,
        child: SpinKitCircle(
          color: AppColors.mainOrangeColor,
          size: size.width / 8,
        ),
      );
    });
void navigateToPage(BuildContext context, int pageIndex) {
  PageController controller = PageController(initialPage: pageIndex);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
        ),
        body: PageView(
          controller: controller,
          children: [
            const SettingsPage(),
            const SuggestedStoresView(),
            const HomePage(),
            const FavouritePage(),
            (SharedPreferencesRepository.getBrowsingPostsMode())
                ? browsingModeProfile(const Size(400, 400), "brwosing")
                : BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is UserLoginedIn ||
                          state is UserSignedUp ||
                          globalSharedPreference.getString("currentShop") ==
                              "noShop") {
                        return globalSharedPreference
                                    .getString("currentShop") ==
                                "noShop"
                            ? noSelectedShop(const Size(400, 400), context)
                            : browsingModeProfile(
                                const Size(400, 400), "userMode");
                      }
                      {
                        context.read<WorkTimeCubit>().testOpenTime(
                            openTime: globalSharedPreference
                                .getString("startWorkTime"),
                            closeTime: globalSharedPreference
                                .getString("endWorkTime"));
                        context.read<GetOwnerShopsCubit>().getOwnerShopsRequest(
                            ownerID: globalSharedPreference.getString('ID'),
                            message: 'all');
                        context.read<PostsCubit>().getOwnerPosts(
                            ownerID: globalSharedPreference.getString('ID'),
                            shopID: globalSharedPreference.getString('shopID'));
                        return StorePage(
                            shop: Shop(
                              isActive:
                                  globalSharedPreference.getBool("isActive")!,
                              socialUrl: globalSharedPreference
                                  .getStringList("socialUrl"),
                              shopCategory: globalSharedPreference
                                  .getString("shopCategory")!,
                              location:
                                  globalSharedPreference.getString("location")!,
                              startWorkTime: globalSharedPreference
                                  .getString("startWorkTime")!,
                              endWorkTime: globalSharedPreference
                                  .getString("endWorkTime")!,
                              ownerID:
                                  globalSharedPreference.getString("ID") ?? '0',
                              ownerEmail:
                                  globalSharedPreference.getString("email")!,
                              ownerPhoneNumber: globalSharedPreference
                                  .getString("phoneNumber")!,
                              shopID:
                                  globalSharedPreference.getString("shopID")!,
                              shopName:
                                  globalSharedPreference.getString("shopName")!,
                              ownerName:
                                  globalSharedPreference.getString("name")!,
                              followesNumber: globalSharedPreference
                                  .getInt("followesNumber")!,
                              rate: globalSharedPreference.getDouble("rate"),
                              shopCoverImage: globalSharedPreference
                                  .getString("shopCoverImage"),
                              shopDescription: globalSharedPreference
                                  .getString("shopDescription"),
                              shopPhoneNumber: globalSharedPreference
                                  .getString("shopPhoneNumber"),
                              shopProfileImage: globalSharedPreference
                                  .getString("shopProfileImage"),
                              latitude:
                                  globalSharedPreference.getDouble("latitude")!,
                              longitude: globalSharedPreference
                                  .getDouble("longitude")!,
                            ),
                            profileDisplay: true);
                      }
                    },
                  ),
          ],
        ),
      ),
    ),
  );
}
