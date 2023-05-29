import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopesapp/logic/cubites/cubit/favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/following_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/profile_cubit.dart';
import 'package:shopesapp/logic/cubites/cubit/work_time_cubit.dart';
import 'package:shopesapp/logic/cubites/themes_cubit.dart';
import 'package:shopesapp/logic/cubites/user_cubit.dart';
import 'package:shopesapp/presentation/router/app_roter.dart';
import 'package:flutter/material.dart';
import 'constant/themes.dart';
import 'data/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  AppRouter appRouter = AppRouter();
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: appRouter,
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => ThemesCubit()),
          lazy: false,
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()..initVerified()),
        ),
        BlocProvider(
          create: ((context) => UserAuthCubit(AuthRepository())),
        ),
        BlocProvider(
          create: (context) => FollowingCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => WorkTimeCubit(),
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
