import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'diagnosis_record.dart';
List<DiagnosisRecord> diagnosisHistory = [];
class DiagnosisPage extends StatefulWidget {
  final File image;
  final String result;
  final DateTime data;
  const DiagnosisPage({super.key,required this.image ,
  required this.result ,
  required this.data});
  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  bool _isLoading = true;
  String? _diagnosisResult;
  List<String> fakeResults = [
    "Healthy skin detected",
    "Mild irritation detected",
    "Possible eczema detected",
    "Suspicious skin condition detected",
    "Dry skin identified"
  ];

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
      _diagnosisResult = fakeResults[Random().nextInt(fakeResults.length)];
      _isLoading = false;
    });
    if (_diagnosisResult != null) {
      diagnosisHistory.add(
        DiagnosisRecord(
          image: widget.image,
          result: _diagnosisResult!,
          date: DateTime.now(),
        ),
      );
    }
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
            children: [
              Image.file(widget.image, height: 200),
              SizedBox(height: 20),
              Icon(
                _diagnosisResult == "Healthy skin detected"
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                size: 120,
                color: _diagnosisResult == "Healthy skin detected"
                    ? AppColors.greenColor
                    : AppColors.redColor,
              ),
              SizedBox(height: 20),
              Text(
                _diagnosisResult ?? "Error retrieving result",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                _diagnosisResult == "Healthy skin detected"
                    ? "Keep up your healthy skincare routine!"
                    : "Consider consulting a dermatologist for further analysis.",
                style:
                TextStyle(fontSize: 16, color: AppColors.blackColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
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