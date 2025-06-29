import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/supabase/supabase_request_result.dart';
import '../../data/models/auth_params.dart';
import '../../data/repository/auth_repo.dart';
import 'login_state.dart';

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
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(
          status: LoginStateStatus.success,
          userId: data,
        ));

      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
          status: LoginStateStatus.failure,
          errorMessage: errorModel.message,
        ));
        default:
break;}
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(
      status: LoginStateStatus.togglePasswordObscure,
      isPasswordObscure: !state.isPasswordObscure,
    ));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
