import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/pages/control_page.dart';
import 'package:shopesapp/presentation/pages/login_page.dart';
import 'package:shopesapp/presentation/pages/porfile.dart';
import 'package:shopesapp/presentation/pages/privacy%20policies.dart';
import 'package:shopesapp/presentation/pages/settings.dart';
import 'package:shopesapp/presentation/pages/verify_password.dart';
import '../../logic/cubites/user_cubit.dart';
import '../../logic/cubites/user_state.dart';
import '../pages/user_sign_up.dart';

class AppRouter {
  Route? onGeneratedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<UserAuthCubit, UserAuthState>(
              builder: ((context, state) {
            /* if (state is UserAuthLoginedIn) {
              return const ControlPage();
            } else {
               return const StartPage();           
            }*/
            return const ControlPage();
          }));
        });
      case '/user':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<UserAuthCubit, UserAuthState>(
              builder: ((context, state) {
            /* if (state is UserAuthLoginedIn) {
              return const HomePage();
            } else {
               return const AuthPage(); 
            }*/
            return const UserSignUp();
          }));
        });
      case '/control':
        return MaterialPageRoute(builder: (context) {
          return const ControlPage();
        });
      case '/verifiy':
        return MaterialPageRoute(builder: (context) {
          return const VerifyPassword();
        });
      case '/settings':
        return MaterialPageRoute(builder: (context) {
          return const SettingsPage();
        });
      case '/privacy&policies':
        return MaterialPageRoute(builder: (context) {
          return const PrivacyPlicies();
        });
      case '/login':
        return MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });

      case '/profile':
        return MaterialPageRoute(builder: (context) {
          /* return BlocBuilder<UserAuthCubit, UserAuthState>(
              builder: ((context, state) {
            //if (state is UserAuthLoginedIn) {
            if (state is UserAuthInitialState) {
              return const ProfilePage();
            } else {
              return const StartPage();
            }
          }));*/
          return const ProfilePage();
        });
    }
    return null;
  }
}
