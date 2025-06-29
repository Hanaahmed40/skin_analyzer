import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DiagnosisLoadingWidget extends StatelessWidget {
  const DiagnosisLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        CircularProgressIndicator(color: AppColors.primaryLight),
        Text(
          "Analyzing... Please wait",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight),
        )
      ],
    );
  }
}
