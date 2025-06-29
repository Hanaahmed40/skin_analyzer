import 'package:flutter/material.dart';

import '../models/predict_response.dart';
import 'predict_detail_item.dart';

class DiagnosisPredictionDialogContent extends StatelessWidget {
  const DiagnosisPredictionDialogContent({
    super.key,
    required this.prediction,
  });

  final PredictResponse prediction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: PredictDetailItem(
                title: "Disease",
                detail: prediction.disease,
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                  title: "Description", detail: prediction.description),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: PredictDetailItem(
                title: "Severity",
                detail: prediction.severity,
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                  title: "Recommendation", detail: prediction.recommendation),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: PredictDetailItem(
                title: "Suggested Treatment",
                detail: prediction.suggestedTreatment,
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                title: "Confidence",
                detail: prediction.confidence.toStringAsFixed(2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
