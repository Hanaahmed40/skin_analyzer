import 'dart:io';

import 'package:event_planning/api_service/api_repo.dart';
import 'package:event_planning/api_service/api_result.dart' as api;
import 'package:event_planning/api_service/request_response.dart';
import 'package:event_planning/cubits/diagnosis_state.dart';
import 'package:event_planning/cubits/main_cubit.dart';
import 'package:event_planning/models/predict_response.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/supabase/supabase_request_result.dart' as supa;
import '../repositories/main_repo.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final MainRepo _mainRepo;
  final ApiRepo _apiRepo;

  DiagnosisCubit(this._mainRepo, this._apiRepo)
      : super(DiagnosisState.initial());

  Future<String> uploadImageToSupabase(File imageFile) async {
    final fileExt = imageFile.path.split('.').last;
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = 'public/$fileName.$fileExt';

    final bytes = await imageFile.readAsBytes();

    await Supabase.instance.client.storage
        .from('diagnosis_images')
        .uploadBinary(filePath, bytes,
            fileOptions: const FileOptions(upsert: true));

    final publicUrl = Supabase.instance.client.storage
        .from('diagnosis_images')
        .getPublicUrl(filePath);

    return publicUrl;
  }

  void predict(BuildContext context) async {
    final pickedImg = context.read<MainCubit>().state.pickedImg;
    if (pickedImg == null) return;

    emit(state.copyWith(status: DiagnosisStateStatus.predictLoading));

    final result = await _apiRepo.predict(pickedImg);

    if (result is api.SupabaseRequestSuccess<RequestResponse>) {
      final prediction = result.data.predictions.first;

      emit(state.copyWith(
        status: DiagnosisStateStatus.predictSuccess,
        prediction: result.data,
      ));

      try {
        final imageUrl = await uploadImageToSupabase(pickedImg);

        await Supabase.instance.client.from('history').insert({
          'image_url': imageUrl,
          'disease': prediction.disease,
          'description': prediction.description,
          'severity': prediction.severity,
          'recommendation': prediction.recommendation,
          'suggested_treatment': prediction.suggestedTreatment,
          'confidence': prediction.confidence,
          'created_at': DateTime.now().toIso8601String(),
        });

        print("✅ Inserted into Supabase successfully.");
      } catch (e) {
        print("❌ Error inserting into Supabase: $e");
      }
    } else if (result is api.SupabaseRequestFailure<RequestResponse>) {
      emit(state.copyWith(
        status: DiagnosisStateStatus.predictFailure,
        errorMessage: result.errorModel.error,
      ));
    }
  }
void fetchRandomPrediction() async {
  emit(state.copyWith(status: DiagnosisStateStatus.fakePredictLoading));
  await Future.delayed(const Duration(seconds: 3));
  final result = await _mainRepo.fetchRandomPrediction();

  if (result is supa.SupabaseRequestSuccess<PredictResponse>) {
    final data = result.data;
    emit(state.copyWith(
      status: DiagnosisStateStatus.fakePredictSuccess,
      fakePrediction: data,
    ));
  } else if (result is supa.SupabaseRequestFailure<PredictResponse>) {
    final error = result.errorModel;
    emit(state.copyWith(
      status: DiagnosisStateStatus.fakePredictFailure,
      errorMessage: error.message,
    ));
  }
}
}