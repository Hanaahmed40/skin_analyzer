import 'package:event_planning/auth/login/presentation/cubits/login_cubit.dart';
import 'package:event_planning/cubits/diagnosis_cubit.dart';
import 'package:event_planning/cubits/register_cubit.dart';
import 'package:event_planning/di.dart';
import 'package:event_planning/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../forget_password/forget_screen.dart';
import '../../auth/login/presentation/register_screen.dart';
import '../../auth/login/presentation/login_screen.dart';
import '../../ui/home_screen/home_screen.dart';
import '../../ui/home_screen/pages/analysisPage.dart';
import '../../ui/home_screen/pages/diagnosisPage.dart';
import '../utils/app_utils.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': // initial route
        return isOnboardingVisited == false
            ? _onboardingRoute()
            : (isUserLoggedIn ? _homeRoute() : _loginRoute());

      case Routes.login:
        return _loginRoute();

      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<RegisterCubit>(
                  create: (context) => getIt.get<RegisterCubit>(),
                  child: RegisterScreen(),
                ));

      case Routes.forgotPass:
        return MaterialPageRoute(builder: (_) => ForgetScreen());

      case Routes.home:
        return _homeRoute();

      case Routes.analysis:
        return MaterialPageRoute(builder: (_) => AnalysisPage());

      case Routes.diagnosis:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<DiagnosisCubit>(
                  create: (context) =>
                      getIt.get<DiagnosisCubit>()..fetchRandomPrediction(),
                  child: DiagnosisPage(),
                ));

      default:
        return _unFoundRoute();
    }
  }

  static MaterialPageRoute<dynamic> _onboardingRoute() {
    return MaterialPageRoute(builder: (_) => OnBoardingScreen());
  }

  static MaterialPageRoute<dynamic> _homeRoute() {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  static MaterialPageRoute<dynamic> _loginRoute() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: const LoginScreen(),
      ),
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
