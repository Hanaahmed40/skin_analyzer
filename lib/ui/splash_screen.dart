import 'dart:async';
import 'package:event_planning/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_planning/core/router/routes.dart';
import 'package:event_planning/core/utils/functions/check_if_onboarding_is_visited.dart';
import 'package:event_planning/core/utils/functions/check_if_user_is_logged_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Timer(const Duration(seconds: 8), () async {
      await checkIfOnboardingIsVisited();
      await checkIfIsUserLoggedIn();

      if (!isOnboardingVisited) {
        Navigator.pushReplacementNamed(context, Routes.onboarding);
      } else {
        if (isUserLoggedIn) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeTransition(
            opacity: _animation,
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/n_splash.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Developed by the team",
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}