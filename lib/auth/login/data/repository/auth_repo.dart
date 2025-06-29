import 'package:event_planning/core/utils/functions/execute_and_handle_errors.dart';

import '../../../../core/supabase/supabase_request_result.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/auth_params.dart';

abstract class AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepo(this.remoteDataSource);

  Future<SupabaseRequestResult<String?>> auth(AuthParams params);
}

class LoginRepo extends AuthRepo {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepo(this._remoteDataSource) : super(_remoteDataSource);

  @override
  Future<SupabaseRequestResult<String?>> auth(AuthParams params) {
    return executeAndHandleErrors<String?>(() async {
      final authResponse = await _remoteDataSource.auth(params);
      return authResponse.user!.id;
    });
  }
}

class RegisterRepo extends AuthRepo {
  final RegisterRemoteDataSource _remoteDataSource;

  RegisterRepo(this._remoteDataSource) : super(_remoteDataSource);

  @override
  Future<SupabaseRequestResult<String?>> auth(AuthParams params) {
    return executeAndHandleErrors<String?>(() async {
      final authResponse = await _remoteDataSource.auth(params);
      return authResponse.user!.id;
    });
  }
}
