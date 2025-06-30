class UserModel {
  final String? name, email, userId, createdAt, avatarUrl;

  UserModel({
    this.name,
    this.email,
    this.userId,
    this.createdAt,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        userId: json['userId'],
        createdAt: json['created_at'],
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'userId': userId,
        'created_at': createdAt,
        'avatar_url': avatarUrl
      };
}
