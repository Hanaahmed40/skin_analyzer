import 'dart:io' show File;

import 'models/predict_response.dart';
import 'models/tip.dart';

enum MainStateStatus {
  initial,
  pickImg,
  predictLoading,
  predictSuccess,
  predictFailure,
  addToHistoryLoading,
  addToHistorySuccess,
  addToHistoryFailure,
  fetchRandomTipLoading,
  fetchRandomTipSuccess,
  fetchRandomTipFailure,
}

class MainState {
  final MainStateStatus status;
  final File? pickedImg;
  final List<PredictResponse>? prediction;
  final List<Tip>? tips;
  final String? errorMessage;

  MainState({
    required this.status,
    this.pickedImg,
    this.prediction,
    this.tips,
    this.errorMessage,
  });

  factory MainState.initial() => MainState(
        status: MainStateStatus.initial,
      );

  MainState copyWith({
    MainStateStatus? status,
    File? pickedImg,
    List<PredictResponse>? prediction,
    List<Tip>? tips,
    String? errorMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      pickedImg: pickedImg ?? this.pickedImg,
      prediction: prediction ?? this.prediction,
      tips: tips ?? this.tips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
