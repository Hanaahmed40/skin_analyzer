import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/utils/app_utils.dart';
import '../models/predict_response.dart';

class MainRemoteDataSource {
  final SupabaseClient _supabaseClient;

  MainRemoteDataSource(this._supabaseClient);

  Future<Map<String, dynamic>> _fetchRemoteData() async {
    return await _supabaseClient
        .from(AppUtils.remoteTableName)
        .select()
        .eq(AppUtils.remoteTableIdColumnName, AppUtils.remoteTableId)
        .single();
  }

  Future<PredictResponse> fetchRandomPrediction() async {
    final remoteJson = await _fetchRemoteData();
    final predictionsJson = remoteJson['predictions'] as List<dynamic>;
    final predictions =
        predictionsJson.map((e) => PredictResponse.fromJson(e)).toList();
    predictions.shuffle();
    return predictions.first;
  }
}
