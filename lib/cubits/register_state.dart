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
  final String? errorMessage, userId;
  final bool isPasswordObscure, isConfirmPassObscure;

  RegisterState({
    required this.status,
    this.errorMessage,
    this.userId,
    this.isPasswordObscure = true,
    this.isConfirmPassObscure = true,
  });

  factory RegisterState.initial() =>
      RegisterState(status: RegisterStateStatus.initial);

  RegisterState copyWith({
    RegisterStateStatus? status,
    String? errorMessage,
    String? userId,
    bool? isPasswordObscure,
    bool? isConfirmPassObscure,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isConfirmPassObscure: isConfirmPassObscure ?? this.isConfirmPassObscure,
    );
  }
}
