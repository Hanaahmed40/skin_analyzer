import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/core/utils/app_utils.dart';
import 'package:event_planning/cubits/main_cubit.dart';
import 'package:event_planning/ui/home_screen/pages/analysisPage.dart';
import 'package:event_planning/ui/home_screen/widget/home_header.dart';
import 'package:event_planning/widget/random_tip_content_bloc_selector.dart';
import 'package:event_planning/widget/show_random_tip_icon_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/core/helpers/current_user.dart' hide currentUser;
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/pages/skin_health_checker.dart';


class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.appTheme == ThemeMode.dark;
    final imagePath = isDark
        ? 'assets/images/img_dark.jpg'
        : 'assets/images/img_1.png';

    return Scaffold(
      body: Column(
        children: [
         HomeHeader(
            username: currentUser?.name ?? 'User',
            isDarkMode: isDark,
            onToggleTheme: () => themeProvider.toggleTheme(),
             onLogout: () { },
          ),
          const SizedBox(height: 20),

          Center(
      
            child: Image.asset(
              imagePath,
              //width: 400,
              //height: 400,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),

          /// ✅ زرار Start New Analysis
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalysisPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              backgroundColor: const Color(0xFF017CFD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              "Start New Analysis",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),

      /// ✅ زرار النصيحة العشوائية
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<MainCubit>().fetchRandomTip();
          context.showAppDialog(
            title: 'Tip for Today',
            contentWidget: const RandomTipContentBlocSelector(),
          );
        },
        backgroundColor: AppColors.primaryLight,
        child: const ShowRandomTipIconBlocBuilder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// ✅ Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryLight,
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalysisPage()),
                );},
            ),
            IconButton(
              icon: const Icon(
                Icons.health_and_safety,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SkinHealthChecker()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}