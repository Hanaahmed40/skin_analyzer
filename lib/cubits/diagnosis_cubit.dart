import 'package:event_planning/cubits/diagnosis_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/supabase/supabase_request_result.dart';
import '../repositories/main_repo.dart';
import 'package:event_planning/models/predict_response.dart'; // تأكد إنه متضاف

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final MainRepo _mainRepo;

  DiagnosisCubit(this._mainRepo) : super(DiagnosisState.initial());

  void fetchRandomPrediction() async {
    emit(state.copyWith(status: DiagnosisStateStatus.predictLoading));

    await Future.delayed(Duration(seconds: 3));

    final result = await _mainRepo.fetchRandomPrediction();

    switch (result) {
      case SupabaseRequestSuccess(:final data):
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
}
