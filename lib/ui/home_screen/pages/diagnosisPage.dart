import 'package:event_planning/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../widget/diagnosis_body_bloc_builder.dart';
import 'diagnosis_record.dart';

List<DiagnosisRecord> diagnosisHistory = [];

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        centerTitle: true,
        title: Text("Diagnosis"),
      ),
      body: Center(
        child: const DiagnosisBodyBlocBuilder(),
      ),
    );
  }
}
