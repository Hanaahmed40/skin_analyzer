import 'package:event_planning/models/predict_response.dart';

enum DiagnosisStateStatus {
  initial,
  predictLoading,
  predictSuccess,
  predictFailure,
}

class DiagnosisState {
  final DiagnosisStateStatus status;
  final PredictResponse? prediction;
  final String? errorMessage;

  DiagnosisState({
    required this.status,
    this.prediction,
    this.errorMessage,
  });

  factory DiagnosisState.initial() =>
      DiagnosisState(status: DiagnosisStateStatus.initial);

  DiagnosisState copyWith({
    DiagnosisStateStatus? status,
    PredictResponse? prediction,
    String? errorMessage,
  }) {
    return DiagnosisState(
      status: status ?? this.status,
      prediction: prediction ?? this.prediction,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
