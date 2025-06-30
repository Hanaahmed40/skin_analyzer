class AuthParams {
  final String email, password;
  final String? name;

  AuthParams({
    required this.email,
    required this.password,
    this.name,
  });
}
