import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> auth(AuthParams params);
}

class LoginRemoteDataSource implements AuthRemoteDataSource {
  final GoTrueClient _supabaseAuth;

  LoginRemoteDataSource(this._supabaseAuth);

  @override
  Future<AuthResponse> auth(AuthParams params) {
    return _supabaseAuth.signInWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterRemoteDataSource implements AuthRemoteDataSource {
  final GoTrueClient _supabaseAuth;

  RegisterRemoteDataSource(this._supabaseAuth);

  @override
  Future<AuthResponse> auth(AuthParams params) {
    return _supabaseAuth.signUp(
      email: params.email,
      password: params.password,
    );
  }
}
