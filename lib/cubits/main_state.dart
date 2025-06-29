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
  final Tip? tip;
  final String? errorMessage;

  MainState({
    required this.status,
    this.pickedImg,
    this.tip,
    this.errorMessage,
  });

  factory MainState.initial() => MainState(
        status: MainStateStatus.initial,
      );

  MainState copyWith({
    MainStateStatus? status,
    File? pickedImg,
    Tip? tip,
    String? errorMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      pickedImg: pickedImg ?? this.pickedImg,
      tip: tip ?? tip,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
