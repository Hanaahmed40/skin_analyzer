import 'package:event_planning/core/helpers/extensions.dart';
import 'package:event_planning/cubits/main_cubit.dart';
//import 'package:event_planning/providers/app_language_provider.dart';
//import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/pages/analysisPage.dart';
import 'package:event_planning/ui/home_screen/pages/diagnosisPage.dart';
//import 'package:event_planning/ui/home_screen/pages/profile_screen.dart'; // حذفناها
import 'package:event_planning/ui/home_screen/pages/history_page.dart';

import '../../widget/random_tip_content_bloc_selector.dart';
import '../../widget/show_random_tip_icon_bloc_builder.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planning/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // حذفنا صفحة البروفايل، بقيت صفحتين فقط
  final List<Widget> _pages = [
    AnalysisPage(),
    HistoryPage(),
  ];

  void onTabTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryLight,
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: AppColors.whiteColor,
                size: 35,
              ),
              onPressed: () => onTabTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.article_sharp,
                color: AppColors.whiteColor,
                size: 35,
              ),
              onPressed: () => onTabTapped(1),
            ),
            // حذفنا زر البروفايل
          ],
        ),
      ),
    );
  }
}

