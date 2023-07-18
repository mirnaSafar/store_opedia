import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/profile_cubit.dart';
import 'package:shopesapp/logic/cubites/post/filter_cubit.dart';
import 'package:shopesapp/logic/cubites/post/post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/post/posts_cubit.dart';
import 'package:shopesapp/logic/cubites/post/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/rate_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/shop_follwers_counter_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/store_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/switch_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/presentation/router/app_roter.dart';
import 'package:flutter/material.dart';
import 'constant/themes.dart';
import 'logic/cubites/cubit/verify_password_cubit.dart';
import 'logic/cubites/mode/themes_cubit.dart';
import 'logic/cubites/shop/get_owner_shops_cubit.dart';

late SharedPreferences globalSharedPreference;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalSharedPreference = await SharedPreferences.getInstance();
  // globalSharedPreference.clear();
  await Settings.init(cacheProvider: SharePreferenceCache());
  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  AppRouter appRouter = AppRouter();
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: appRouter,
      connectivity: Connectivity(),
    )),
    storage: storage,
  );
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
      ],
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, state) {
          return MaterialApp(
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            title: 'ShopsApp',
            debugShowCheckedModeBanner: false,
            theme: themeArray[state.themeIndex],
            onGenerateRoute: appRouter.onGeneratedRoutes,
          );
        },
      ),
    );
  }
}
