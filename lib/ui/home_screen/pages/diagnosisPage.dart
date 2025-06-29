import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/widget/picked_img_bloc_selector.dart';
import 'package:flutter/material.dart';
import 'diagnosis_record.dart';

List<DiagnosisRecord> diagnosisHistory = [];

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});
  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateAnalysis();
  }

  Future<void> _simulateAnalysis() async {
    // Simulate loading
    await Future.delayed(Duration(seconds: 3));

    // Pick a random fake result
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryLight),
      body: Center(
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryLight),
                  SizedBox(height: 20),
                  Text(
                    "Analyzing... Please wait",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryLight),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    const PickedImgBlocSelector(),
                    SizedBox(height: 20),
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 120,
                      color: AppColors.redColor,
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.home, color: AppColors.whiteColor),
                      label: Text("Back to Home",
                          style: TextStyle(color: AppColors.whiteColor)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
