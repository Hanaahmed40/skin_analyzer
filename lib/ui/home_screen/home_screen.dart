

import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home_screen/language_bottom_sheet.dart';
import 'package:event_planning/ui/home_screen/pages/analysisPage.dart';
import 'package:event_planning/ui/home_screen/pages/diagnosisPage.dart';
import 'package:event_planning/ui/home_screen/pages/homePage.dart';
import 'package:event_planning/ui/home_screen/theme_bottom_sheet.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:event_planning/ui/home_screen/pages/history_page.dart';
import 'package:event_planning/ui/home_screen/pages/diagnosis_record.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    AnalysisPage(),
    HistoryPage(history: diagnosisHistory)
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(

      body:
      _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTabTapped(0),
        backgroundColor: AppColors.primaryLight,
        child: Icon(Icons.home_sharp, size: 30 , color:  AppColors.whiteColor,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryLight,
        elevation: 10,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt , color: AppColors.whiteColor, size: 35,),
              onPressed: () => onTabTapped(1),
            ),

            SizedBox(width: 40), // Space for FAB
            IconButton(
              icon: Icon(Icons.article_sharp , color: AppColors.whiteColor, size: 35,),
              onPressed: () => onTabTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}