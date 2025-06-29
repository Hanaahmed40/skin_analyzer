import 'package:event_planning/auth/login/presentation/cubits/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/supabase/supabase_request_result.dart';
import '../../data/models/auth_params.dart';
import '../../data/repository/auth_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginState.initial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    emit(state.copyWith(status: LoginStateStatus.loading));
    final result = await _loginRepo.auth(
      AuthParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    switch (result) {
      case SupabaseRequestSuccess<String?>(:final data):
        emit(state.copyWith(
          status: LoginStateStatus.success,
          userId: data,
        ));
        break;
      case SupabaseRequestFailure<String?>(:final errorModel):
        emit(state.copyWith(
          status: LoginStateStatus.failure,
          errorMessage: errorModel.message,
        ));
        break;
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
