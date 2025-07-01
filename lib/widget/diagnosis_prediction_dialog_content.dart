import 'package:event_planning/api_service/request_response.dart';
import 'package:flutter/material.dart';

import '../models/predict_response.dart';
import 'predict_detail_item.dart';

class DiagnosisPredictionDialogContent extends StatelessWidget {
  const DiagnosisPredictionDialogContent({
    super.key,
    this.fakePrediction,
    this.prediction,
  });

  final PredictResponse? fakePrediction;
  final RequestResponse? prediction;

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
                detail: fakePrediction?.disease ?? 'Unknown Disease',
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                  title: "Description",
                  detail: fakePrediction?.description ?? 'Unknown Description'),
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
                detail: fakePrediction?.severity ?? 'Unknown Severity',
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                  title: "Recommendation",
                  detail: fakePrediction?.recommendation ??
                      'Unknown Recommendation'),
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
                detail:
                    fakePrediction?.suggestedTreatment ?? 'Unknown Treatment',
              ),
            ),
            Expanded(
              child: PredictDetailItem(
                title: "Confidence",
                detail: fakePrediction?.confidence.toStringAsFixed(2) ??
                    'Unknown Confidence',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
