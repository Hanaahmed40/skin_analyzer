import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../models/auth_params.dart';
import '../../../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> auth(AuthParams params);
}

class LoginRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  LoginRemoteDataSource(this._supabaseClient);

  @override
  Future<UserModel> auth(AuthParams params) async {
    final authResponse = await _supabaseClient.auth.signInWithPassword(
      email: params.email,
      password: params.password!,
    );
    final userJson = await _supabaseClient
        .from(AppUtils.profilesTable)
        .select()
        .eq('userId', authResponse.user!.id)
        .single();
    return UserModel.fromJson(userJson);
  }
}

class RegisterRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  RegisterRemoteDataSource(this._supabaseClient);

  @override
  Future<UserModel> auth(AuthParams params) async {
    final authResponse = await _supabaseClient.auth.signUp(
      email: params.email,
      password: params.password!,
      data: {'name': params.name},
    );
     // ✅ تسجيل الدخول مباشرة بعد التسجيل لضمان session
    await _supabaseClient.auth.signInWithPassword(
      email: params.email!,
      password: params.password!,
    );
    
    final supabaseUser = authResponse.user;
    final user = UserModel(
        userId: supabaseUser!.id,
        name: params.name,
        email: params.email,
     //   password: params.password,
        avatarUrl: supabaseUser.userMetadata!['avatar_url']);
    await _supabaseClient.from(AppUtils.profilesTable).insert(user.toJson());
    return user;
  }
}
