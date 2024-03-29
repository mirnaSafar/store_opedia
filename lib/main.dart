import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/profile_cubit.dart';
import 'package:shopesapp/logic/cubites/post/cubit/show_favorite_posts_cubit.dart';
import 'package:shopesapp/logic/cubites/post/cubit/toggle_post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/filter_cubit.dart';
import 'package:shopesapp/logic/cubites/post/post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/posts_cubit.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/search_store_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/show_favorite_stores_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/toggole_favorite_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/toggole_follow_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/get_shops_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/shop_follwers_counter_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/store_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/switch_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/presentation/router/app_roter.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/translation/codegen_loader.g.dart';

//import 'package:shopesapp/translations/codegen_loader.g.dart';
import 'constant/themes.dart';
import 'logic/cubites/cubit/get_caht_messages_cubit.dart';
import 'logic/cubites/cubit/verify_password_cubit.dart';
import 'logic/cubites/mode/themes_cubit.dart';
import 'logic/cubites/shop/get_owner_shops_cubit.dart';

late SharedPreferences globalSharedPreference;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalSharedPreference = await SharedPreferences.getInstance();
  // globalSharedPreference.clear();
  await EasyLocalization.ensureInitialized();

  await Settings.init(cacheProvider: SharePreferenceCache());
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

  AppRouter appRouter = AppRouter();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),
    startLocale: const Locale.fromSubtags(languageCode: 'en'),
    child: MyApp(
      appRouter: appRouter,
      connectivity: Connectivity(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter, required this.connectivity})
      : super(key: key);

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PostsCubit(),
        ),
        BlocProvider(
          create: (context) => SearchStoreCubit(),
        ),
        BlocProvider(
          create: (context) => GetShopsCubit(),
        ),
        BlocProvider(
          create: (context) => StoreCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GetOwnerShopsCubit(),
        ),
        BlocProvider(
          create: ((context) => ThemesCubit()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PostFavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => ShowFavoritePostsCubit(),
        ),
        BlocProvider(
          create: (context) => ShowFavoriteStoresCubit(),
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()..initVerified()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SwitchShopCubit(),
        ),
        BlocProvider(
          create: ((context) => VerifyPasswordCubit()),
        ),
        BlocProvider(
          create: ((context) => AuthCubit()..autoLogIn()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FollowingCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ToggoleFollowShopCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ToggoleFavoriteShopCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => TogglePostFavoriteCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ShowFavoritePostsCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => RateShopCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => RatePostCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ShopFollwersCounterCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => WorkTimeCubit(),
        ),
        BlocProvider(
          create: (context) => GetCahtMessagesCubit(),
        ),
      ],
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              title: 'ShopsApp',
              debugShowCheckedModeBanner: false,
              theme: themeArray[state.themeIndex],
              onGenerateRoute: appRouter.onGeneratedRoutes,
            );
          });
        },
      ),
    );
  }
}
