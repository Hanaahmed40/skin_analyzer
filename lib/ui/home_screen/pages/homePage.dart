import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
      ),
      body: Center(child: Text('Welcome to Home!')),
    );
  }
}
