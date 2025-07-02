import 'dart:io';

import 'package:event_planning/ui/home_screen/pages/diagnosis_record.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/supabase/supabase_request_result.dart';
import '../core/utils/functions/execute_and_handle_errors.dart';
import '../data_source/main_remote_data_source.dart';
import '../models/predict_response.dart';
import '../models/tip.dart';

class MainRepo {
  final MainRemoteDataSource _mainRemoteDataSource;

  MainRepo(this._mainRemoteDataSource);

  Future<SupabaseRequestResult<PredictResponse>> fetchRandomPrediction() {
    return executeAndHandleErrors<PredictResponse>(
      () async => await _mainRemoteDataSource.fetchRandomPrediction(),
    );
  }

  Future<SupabaseRequestResult<Tip>> fetchRandomTip() {
    return executeAndHandleErrors<Tip>(
      () async => await _mainRemoteDataSource.fetchRandomTip(),
    );
  }

  Future<List<DiagnosisRecord>> fetchHistory() async {
    final response = await Supabase.instance.client
        .from('history')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => DiagnosisRecord.fromJson(e))
        .toList();
  }

  Future<void> addToHistory({
  required File image,
  required PredictResponse prediction,
}) async {
  final imagePath = 'history/${DateTime.now().millisecondsSinceEpoch}.jpg';

  final storageResponse = await Supabase.instance.client.storage
      .from('images') // ← غيّري اسم الباكت لو مختلف
      .upload(imagePath, image);

  final imageUrl = Supabase.instance.client.storage
      .from('images')
      .getPublicUrl(imagePath);

  print("📸 Uploaded image URL: $imageUrl");

  final response = await Supabase.instance.client.from('history').insert({
    'image_url': imageUrl,
    'disease': prediction.disease,
    'description': prediction.description,
    'severity': prediction.severity,
    'recommendation': prediction.recommendation,
    'suggested_treatment': prediction.suggestedTreatment,
    'confidence': prediction.confidence,
    'created_at': DateTime.now().toIso8601String(),
  });

  print("📦 Inserted history response: $response");
}
}