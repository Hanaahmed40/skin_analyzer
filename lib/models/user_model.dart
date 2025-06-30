import 'dart:convert' show json;

import '../core/helpers/cache_keys.dart';
import '../core/helpers/secure_storage_helper.dart';

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

  UserModel copyWith({
    String? email,
    String? name,
    String? userId,
    String? createdAt,
    String? avatarUrl,
  }) =>
      UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

  static Future<void> secureUser(UserModel user) async {
    await SecureStorageHelper.setSecuredString(
      CacheKeys.user,
      json.encode(user.toJson()),
    );
  }

  static Future<UserModel> getSecuredUser() async {
    final userString =
        await SecureStorageHelper.getSecuredString(CacheKeys.user);
    return UserModel.fromJson(json.decode(userString));
  }

  static Future<void> deleteSecuredUser() async {
    await SecureStorageHelper.removeSecuredData(CacheKeys.user);
  }
}
