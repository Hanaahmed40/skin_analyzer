import 'package:flutter/material.dart';

import '../../forget_password/forget_screen.dart';
import '../../auth/login/presentation/register_screen.dart';
import '../../auth/login/presentation/login_screen.dart';
import '../../ui/home_screen/home_screen.dart';
import '../utils/app_utils.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': // initial route
        return isUserLoggedIn ? _homeRoute() : _loginRoute();

      case Routes.login:
        return _loginRoute();

      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case Routes.forgotPass:
        return MaterialPageRoute(builder: (_) => ForgetScreen());

      case Routes.home:
        return _homeRoute();

      default:
        return _unFoundRoute();
    }
  }

  static MaterialPageRoute<dynamic> _homeRoute() {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  static MaterialPageRoute<dynamic> _loginRoute() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    );
  }

  static Route<dynamic> _unFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            "Un found route",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
