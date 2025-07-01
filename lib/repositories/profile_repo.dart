import 'package:event_planning/data_source/profile_remote_data_source.dart';
import 'package:event_planning/models/auth_params.dart';
import 'package:event_planning/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

import '../core/supabase/supabase_request_result.dart';
import '../core/utils/functions/execute_and_handle_errors.dart';

class ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepo(this._remoteDataSource);

  Future<SupabaseRequestResult<UserModel>> updateProfile(
    AuthParams params,
  ) {
    return executeAndHandleErrors<UserModel>(
      () async => await _remoteDataSource.updateUser(params),
    );
  } 

  Future<SupabaseRequestResult<UserModel>> updatePassword(
    AuthParams params,
  ) {
    return executeAndHandleErrors<UserModel>(
      () async => await _remoteDataSource.updatePassword(params),
    );
  }

  Future<SupabaseRequestResult<void>> logOut() {
    return executeAndHandleErrors<void>(
      () async => await _remoteDataSource.logOut(),
    );
  }

  Future<SupabaseRequestResult<String>> updateProfileImg(XFile? imgFile) {
    return executeAndHandleErrors<String>(
      () async => await _remoteDataSource.updateProfileImg(imgFile),
    );
  }
  
}
