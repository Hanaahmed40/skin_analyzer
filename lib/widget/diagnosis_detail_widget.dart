import 'package:event_planning/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../models/predict_response.dart';
import '../utils/app_colors.dart';
import 'diagnosis_prediction_dialog_content.dart';
import 'picked_img_bloc_selector.dart';

class DiagnosisDetailWidget extends StatelessWidget {
  const DiagnosisDetailWidget({
    super.key,
    required this.prediction,
  });

  final PredictResponse prediction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        const PickedImgBlocSelector(),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => context.showAppDialog(
            title: "Prediction Details",
            contentWidget:
                DiagnosisPredictionDialogContent(prediction: prediction),
          ),
          icon: Icon(Icons.info, color: AppColors.whiteColor),
          label: Text("Show details",
              style: TextStyle(color: AppColors.whiteColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.home, color: AppColors.whiteColor),
          label: Text("Back to Home",
              style: TextStyle(color: AppColors.whiteColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ],
    );
  }
}
