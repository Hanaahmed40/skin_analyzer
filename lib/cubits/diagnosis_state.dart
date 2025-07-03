import 'package:event_planning/api_service/request_response.dart';
import 'package:event_planning/models/predict_response.dart';

enum DiagnosisStateStatus {
  initial,
  fakePredictLoading,
  fakePredictSuccess,
  fakePredictFailure,
  predictLoading,
  predictSuccess,
  predictFailure,
}

class DiagnosisState {
  final DiagnosisStateStatus status;
  final PredictResponse? fakePrediction;
  final String? errorMessage;
  final RequestResponse? prediction;

  DiagnosisState({
    required this.status,
    this.fakePrediction,
    this.errorMessage,
    this.prediction,
  });

  factory DiagnosisState.initial() =>
      DiagnosisState(status: DiagnosisStateStatus.initial);

  DiagnosisState copyWith({
    DiagnosisStateStatus? status,
    PredictResponse? fakePrediction,
    RequestResponse? prediction,
    String? errorMessage,
  }) {
    return DiagnosisState(
      status: status ?? this.status,
      fakePrediction: fakePrediction ?? this.fakePrediction,
      errorMessage: errorMessage ?? this.errorMessage,
      prediction: prediction ?? this.prediction,
    );
  }
}
