enum LoginStateStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState {
  final LoginStateStatus status;
  final String? userId;
  final String? errorMessage;

  const LoginState({
    required this.status,
    this.errorMessage,
    this.userId,
  });

  factory LoginState.initial() => const LoginState(
        status: LoginStateStatus.initial,
      );

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
    String? userId,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
    );
  }
}
