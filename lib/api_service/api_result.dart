import 'package:event_planning/api_service/api_error_model.dart';

sealed class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) => SupabaseRequestSuccess<T>(data);

  factory ApiResult.failure(ApiErrorModel errorModel) =>
      SupabaseRequestFailure<T>(errorModel);
}

class SupabaseRequestSuccess<T> extends ApiResult<T> {
  final T data;
  const SupabaseRequestSuccess(this.data);
}

class SupabaseRequestFailure<T> extends ApiResult<T> {
  final ApiErrorModel errorModel;
  const SupabaseRequestFailure(this.errorModel);
}
