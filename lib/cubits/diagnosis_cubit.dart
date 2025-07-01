import 'package:event_planning/api_service/api_repo.dart';
import 'package:event_planning/api_service/request_response.dart';
import 'package:event_planning/cubits/diagnosis_state.dart';
import 'package:event_planning/cubits/main_cubit.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/supabase/supabase_request_result.dart';
import '../repositories/main_repo.dart';
import 'package:event_planning/models/predict_response.dart'; // تأكد إنه متضاف

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final MainRepo _mainRepo;
  final ApiRepo _apiRepo;

  DiagnosisCubit(this._mainRepo, this._apiRepo)
      : super(DiagnosisState.initial());

  void predict(BuildContext context) async {
    final pickedImg = context.read<MainCubit>().state.pickedImg;
    if (pickedImg == null) return;
    emit(state.copyWith(status: DiagnosisStateStatus.predictLoading));
    final result = await _apiRepo.predict(pickedImg);
    switch (result) {
      case SupabaseRequestSuccess<RequestResponse>(:final data):
        emit(state.copyWith(
          status: DiagnosisStateStatus.predictSuccess,
          prediction: data,
        ));
        break;
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: DiagnosisStateStatus.predictFailure,
          errorMessage: errorModel.message,
        ));
        break;
      default:
        break;
    }
  }

  void fetchRandomPrediction() async {
    emit(state.copyWith(status: DiagnosisStateStatus.fakePredictLoading));

    await Future.delayed(Duration(seconds: 3));

    final result = await _mainRepo.fetchRandomPrediction();

    switch (result) {
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(
          status: DiagnosisStateStatus.fakePredictSuccess,
          fakePrediction: data,
        ));
        break;

      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: DiagnosisStateStatus.fakePredictFailure,
          errorMessage: errorModel.message,
        ));
        break;

      default:
        break;
    }
  }
}
