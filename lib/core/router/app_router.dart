import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/login/presentation/login_screen.dart';
import '../../auth/login/presentation/register_screen.dart';
import '../../forget_password/forget_screen.dart';
import '../../ui/home_screen/home_screen.dart';
import '../../ui/home_screen/pages/analysisPage.dart';
import '../../ui/home_screen/pages/diagnosisPage.dart';
import '../../ui/onboarding_screen.dart';
import '../../cubits/diagnosis_cubit.dart';
import '../../cubits/register_cubit.dart';
import '../../auth/login/presentation/cubits/login_cubit.dart';
//import '../utils/app_utils.dart';
import 'package:event_planning/di.dart';
import '../../ui/splash_screen.dart'; 
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': // Initial route => SplashScreen
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return _onboardingRoute();

      case Routes.login:
        return _loginRoute();

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterCubit>(
            create: (context) => getIt.get<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

      case Routes.forgotPass:
        return MaterialPageRoute(builder: (_) => const ForgetScreen());

      case Routes.home:
        return _homeRoute();

      case Routes.analysis:
        return MaterialPageRoute(builder: (_) => const AnalysisPage());

      case Routes.diagnosis:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<DiagnosisCubit>(
            create: (context) =>
                getIt.get<DiagnosisCubit>()..fetchRandomPrediction(),
            child: const DiagnosisPage(),
          ),
        );

      default:
        return _unFoundRoute();
    }
  }

  static MaterialPageRoute _onboardingRoute() {
    return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
  }

  static MaterialPageRoute _homeRoute() {
    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }

  static MaterialPageRoute _loginRoute() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: const LoginScreen(),
      ),
    );
  }

  static Route<dynamic> _unFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            "Unfound route",
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