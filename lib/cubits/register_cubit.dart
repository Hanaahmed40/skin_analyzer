import 'package:event_planning/core/supabase/supabase_request_result.dart';
import 'package:event_planning/cubits/register_state.dart';
import 'package:event_planning/models/auth_params.dart' as model_params;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:event_planning/auth/login/data/repository/auth_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super(RegisterState.initial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  void register() async {
    emit(state.copyWith(status: RegisterStateStatus.loading));
    final result = await _registerRepo.auth(
      model_params.AuthParams(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
    switch (result) {
      case SupabaseRequestSuccess(:final data):
        emit(state.copyWith(status: RegisterStateStatus.success, userId: data));
      case SupabaseRequestFailure(:final errorModel):
        emit(state.copyWith(
            status: RegisterStateStatus.failure,
            errorMessage: errorModel.message));
      default:
        break;
    }
  }

  void togglePassVisibility() {
    emit(state.copyWith(
      status: RegisterStateStatus.toggleVisibility,
      isPasswordObscure: !state.isPasswordObscure,
    ));
  }

  void toggleConfirmPassVisibility() {
    emit(state.copyWith(
      status: RegisterStateStatus.toggleConfirmPassVisibility,
      isConfirmPassObscure: !state.isConfirmPassObscure,
    ));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    return super.close();
  }
}
