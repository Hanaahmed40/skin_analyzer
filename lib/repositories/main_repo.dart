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
}
