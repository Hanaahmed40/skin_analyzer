class AuthParams {
  final String? email, password;
  final String? name;

  AuthParams({
    this.email,
    this.password,
    this.name,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
