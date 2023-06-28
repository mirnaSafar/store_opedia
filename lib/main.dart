import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/posts_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/profile_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/get_owner_shops_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/following_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/switch_shop_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/logic/cubites/themes_cubit.dart';
import 'package:shopesapp/presentation/router/app_roter.dart';
import 'package:flutter/material.dart';
import 'constant/themes.dart';
import 'data/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ),
        BlocProvider(
          create: (context) => PostsCubit(
            PostsRepository(),
          )..getPosts(),
        ),
        BlocProvider(
          create: (context) => GetOwnerShopsCubit(ShopRepository()),
        ),
        BlocProvider(
          create: ((context) => ThemesCubit()),
          lazy: false,
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()..initVerified()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SwitchShopCubit(AuthRepository()),
        ),
        /*  BlocProvider(
          create: ((context) => VerifyPasswordCubit(AuthRepository())),
        ),*/
        BlocProvider(
          create: ((context) => AuthCubit(
                AuthRepository(),
              )..autoLogIn()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FollowingCubit(),
        ),
        BlocProvider(
          create: (context) => WorkTimeCubit()..testOpenTime(),
        ),
      ],
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, state) {
          return MaterialApp(
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
