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

  User get user {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw const AuthException('Session is missing');
    return user;
  }

  Session get session {
    final session = _supabaseClient.auth.currentSession;
    if (session == null) throw const AuthException('Session is missing');
    return session;
  }

  Future<UserModel> updateUser(AuthParams params) async {
    await _updateSupabaseAuthUser(params);
    await _updateUserDataInDatabase(params);

    return UserModel(
      email: params.email ?? user.email,
      name: params.name ?? user.userMetadata?['name'] ?? '',
      userId: user.id,
      avatarUrl: user.userMetadata?['avatar_url'] ?? '',
    );
  }

  Future<void> _updateSupabaseAuthUser(AuthParams params) async {
    final userAttributes = UserAttributes(
      email: params.email ?? user.email,
      data: {'name': params.name ?? user.userMetadata?['name'] ?? ''},
      password: params.password,
    );

    await _supabaseClient.auth.updateUser(userAttributes);
  }

  Future<void> _updateUserDataInDatabase(AuthParams params) async {
    final existing = await _supabaseClient
        .from(AppUtils.profilesTable)
        .select()
        .eq('userId', user.id);

    final requestParams = AuthParams(
      name: params.name ?? user.userMetadata?['name'] ?? '',
      email: params.email ?? user.email,
    );

    final data = {
      'userId': user.id,
      ...requestParams.toJson(),
    };

    if (existing.isEmpty) {
      await _supabaseClient.from(AppUtils.profilesTable).insert(data);
    } else {
      await _supabaseClient
          .from(AppUtils.profilesTable)
          .update(data)
          .eq('userId', user.id);
    }
  }

  Future<void> logOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<String> updateProfileImg(XFile? imgFile) async {
    session;
    user;

    final avatarUrl = await _upsertImgToStorageAndDatabase(imgFile!);
    log('>>>>>>>>>>>>>>> IMG URL: $avatarUrl <<<<<<<<<<<<<<<');
    await _updateSupabaseUserMetadata(avatarUrl);
    return avatarUrl;
  }

  Future<String> _upsertImgToStorageAndDatabase(XFile imgFile) async {
    final imgPath = '${user.id}/${Uri.file(imgFile.path).pathSegments.last}';
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
    final existing = await _supabaseClient
        .from(AppUtils.profilesTable)
        .select()
        .eq('userId', user.id);

    final userJson = existing.isNotEmpty ? existing.first : {};
    userJson['userId'] = user.id;
    userJson['avatar_url'] = avatarUrl;

    if (existing.isEmpty) {
      await _supabaseClient.from(AppUtils.profilesTable).insert(userJson);
    } else {
      await _supabaseClient
          .from(AppUtils.profilesTable)
          .update(userJson)
          .eq('userId', user.id);
    }
  }

  Future<String> _getAvatarSignedUrl(String imgPath) {
    return _supabaseClient.storage
        .from(AppUtils.imagesStorage)
        .createSignedUrl(imgPath, 60 * 60 * 24 * 365 * 10);
  }

  Future<void> _updateSupabaseUserMetadata(String imgUrl) async {
    final currentMetadata = user.userMetadata ?? {};
    await _supabaseClient.auth.updateUser(
      UserAttributes(data: {...currentMetadata, 'avatar_url': imgUrl}),
    );
  }

  Future<UserModel> updatePassword(AuthParams params) async {
    await _updateSupabaseAuthUserForPassword(params);
    await _updateUserDataInDatabase(params);

    return UserModel(
      email: params.email ?? user.email,
      name: params.name ?? user.userMetadata?['name'] ?? '',
      userId: user.id,
      avatarUrl: user.userMetadata?['avatar_url'] ?? '',
    );
  }

  Future<void> _updateSupabaseAuthUserForPassword(AuthParams params) async {
    if (params.password == null || params.password!.length < 6) {
      throw const AuthException('Password must be at least 6 characters');
    }

    await _supabaseClient.auth.updateUser(
      UserAttributes(
        email: params.email ?? user.email,
        password: params.password,
        data: {'name': params.name ?? user.userMetadata?['name'] ?? ''},
      ),
    );
  }
}
