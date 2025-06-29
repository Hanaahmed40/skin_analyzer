import '../core/supabase/supabase_request_result.dart';
import '../core/utils/functions/execute_and_handle_errors.dart';
import '../data_source/main_remote_data_source.dart';
import '../models/predict_response.dart';

class MainRepo {
  final MainRemoteDataSource _mainRemoteDataSource;

  MainRepo(this._mainRemoteDataSource);

  Future<SupabaseRequestResult<PredictResponse>> fetchRandomPrediction() {
    return executeAndHandleErrors<PredictResponse>(
      () async => await _mainRemoteDataSource.fetchRandomPrediction(),
    );
  }
}
