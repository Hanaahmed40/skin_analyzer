import 'supabase_error.dart';

sealed class SupabaseRequestResult<T> {
  const SupabaseRequestResult();

  factory SupabaseRequestResult.success(T data) =>
      SupabaseRequestSuccess<T>(data);

  factory SupabaseRequestResult.failure(SupabaseError errorModel) =>
      SupabaseRequestFailure<T>(errorModel);
}

class SupabaseRequestSuccess<T> extends SupabaseRequestResult<T> {
  final T data;
  const SupabaseRequestSuccess(this.data);
}

class SupabaseRequestFailure<T> extends SupabaseRequestResult<T> {
  final SupabaseError errorModel;
  const SupabaseRequestFailure(this.errorModel);
}
