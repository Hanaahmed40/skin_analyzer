import 'dart:developer' show log;
import 'dart:io' show File;

import 'package:event_planning/core/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/auth_params.dart';
import '../models/user_model.dart';

class ProfileRemoteDataSource {
  final SupabaseClient _supabaseClient;

  ProfileRemoteDataSource(this._supabaseClient);

  Future<UserModel> updateUser(AuthParams params) async {
    await Future.wait([
      _updateSupabaseAuthUser(params),
      _updateUserDataInDatabase(params),
    ]);
    return currentUser!.copyWith(
      email: params.email ?? currentUser!.email,
      name: params.name ?? currentUser!.name,
      password: params.password ?? currentUser!.password,
    );
  }

  Future<void> _updateSupabaseAuthUser(AuthParams params) async {
    await _supabaseClient.auth.updateUser(
      UserAttributes(
        email: params.email ?? currentUser!.email,
        password: params.password ?? currentUser!.password,
        data: {'name': params.name ?? currentUser!.name},
      ),
    );
  }

  Future<void> _updateUserDataInDatabase(AuthParams params) async {
    final userJson = await _fetchUserFromDatabase();
    await _supabaseClient.from(AppUtils.profilesTable).update(
        {...userJson, ...params.toJson()}).eq('userId', currentUser!.userId!);
  }

  Future<PostgrestMap> _fetchUserFromDatabase() => _supabaseClient
      .from(AppUtils.profilesTable)
      .select()
      .eq('userId', currentUser!.userId!)
      .single();

  Future<void> logOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<String> updateProfileImg(XFile? imgFile) async {
    final avatarUrl = await _upsertImgToStorageAndDatabase(imgFile!);
    log('>>>>>>>>>>>>>>> IMG URL: $avatarUrl <<<<<<<<<<<<<<<');
    await _updateSupabaseUserMetadata(avatarUrl);
    return avatarUrl;
  }

  Future<String> _upsertImgToStorageAndDatabase(XFile imgFile) async {
    final imgPath =
        '${currentUser!.userId!}/${Uri.file(imgFile.path).pathSegments.last}';
    await _upsertImgToStorage(imgPath, imgFile);
    final avatarUrl = await _getAvatarSignedUrl(imgPath);
    await _upsertImgToDatabase(avatarUrl);
    return avatarUrl;
  }

  Future<String> _upsertImgToStorage(String imgPath, XFile imgFile) async {
    return await _supabaseClient.storage.from(AppUtils.imagesStorage).update(
          imgPath,
          File(imgFile.path),
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: true,
            contentType: imgFile.mimeType,
          ),
        );
  }

  Future<void> _upsertImgToDatabase(String avatarUrl) async {
    final userJson = await _fetchUserFromDatabase();
    userJson['avatar_url'] = avatarUrl;
    return _supabaseClient
        .from(AppUtils.profilesTable)
        .update(userJson)
        .eq('user_id', currentUser!.userId!);
  }

  Future<String> _getAvatarSignedUrl(String imgPath) {
    return _supabaseClient.storage
        .from(AppUtils.imagesStorage)
        .createSignedUrl(imgPath, 60 * 60 * 24 * 365 * 10);
  }

  Future<void> _updateSupabaseUserMetadata(String imgUrl) async {
    final currentMetadata =
        _supabaseClient.auth.currentUser?.userMetadata ?? {};
    await _supabaseClient.auth.updateUser(
      UserAttributes(data: {...currentMetadata, 'avatar_url': imgUrl}),
    );
  }
}
