import '../../../../models/user_model.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  failure,
  togglePasswordObscure,
}

class LoginState {
  final LoginStateStatus status;
  final UserModel? user;
  final String? errorMessage;
  final bool isPasswordObscure;

  const LoginState({
    required this.status,
    this.errorMessage,
    this.user,
    this.isPasswordObscure = true,
  });

  factory LoginState.initial() => const LoginState(
        status: LoginStateStatus.initial,
      );

  LoginState copyWith({
    LoginStateStatus? status,
    String? errorMessage,
    UserModel? user,
    bool? isPasswordObscure,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
