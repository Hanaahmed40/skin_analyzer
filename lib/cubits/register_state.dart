import '../models/user_model.dart';

enum RegisterStateStatus {
  initial,
  loading,
  success,
  failure,
  toggleVisibility,
  toggleConfirmPassVisibility,
}

class RegisterState {
  final RegisterStateStatus status;
  final String? errorMessage;
  final UserModel? user;
  final bool isPasswordObscure, isConfirmPassObscure;

  RegisterState({
    required this.status,
    this.errorMessage,
    this.user,
    this.isPasswordObscure = true,
    this.isConfirmPassObscure = true,
  });

  factory RegisterState.initial() =>
      RegisterState(status: RegisterStateStatus.initial);

  RegisterState copyWith({
    RegisterStateStatus? status,
    String? errorMessage,
    UserModel? user,
    bool? isPasswordObscure,
    bool? isConfirmPassObscure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isConfirmPassObscure: isConfirmPassObscure ?? this.isConfirmPassObscure,
    );
  }
}
