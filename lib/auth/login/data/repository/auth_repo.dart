import '../../../../core/supabase/supabase_request_result.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/auth_params.dart';

abstract class AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepo(this.remoteDataSource);

  Future<SupabaseRequestResult<void>> auth(AuthParams params);
}

class LoginRepo extends AuthRepo {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepo(this._remoteDataSource) : super(_remoteDataSource);

  @override
  Future<SupabaseRequestResult<void>> auth(AuthParams params ) {
    return _remoteDataSource.auth(params)
  }
}
