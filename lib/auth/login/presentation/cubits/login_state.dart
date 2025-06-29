enum LoginStateStatus {
  initial,
  loading,
  success,
  failure,
  togglePasswordObscure,
}

class LoginState {
  final LoginStateStatus status;
  final String? userId;
  final String? errorMessage;
  final bool isPasswordObscure;

  const LoginState({
    required this.status,
    this.errorMessage,
    this.userId,
    this.isPasswordObscure = true,
  });

  factory LoginState.initial() => const LoginState(
        status: LoginStateStatus.initial,
      );

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
    String? userId,
    bool? isPasswordObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
