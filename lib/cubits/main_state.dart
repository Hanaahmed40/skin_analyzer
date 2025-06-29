import 'dart:io' show File;

import '../models/tip.dart';

enum MainStateStatus {
  initial,
  pickImg,
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
  final List<Tip>? tips;
  final String? errorMessage;

  MainState({
    required this.status,
    this.pickedImg,
    this.tips,
    this.errorMessage,
  });

  factory MainState.initial() => MainState(
        status: MainStateStatus.initial,
      );

  MainState copyWith({
    MainStateStatus? status,
    File? pickedImg,
    List<Tip>? tips,
    String? errorMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      pickedImg: pickedImg ?? this.pickedImg,
      tips: tips ?? this.tips,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
