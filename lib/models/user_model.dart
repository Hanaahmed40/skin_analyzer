import 'dart:convert' show json;

import '../core/helpers/cache_keys.dart';
import '../core/helpers/secure_storage_helper.dart';

class UserModel {
  final String? name, email, userId, avatarUrl, password;

  UserModel({
    this.name,
    this.email,
    this.userId,
    this.avatarUrl,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        userId: json['userId'],
        avatarUrl: json['avatar_url'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'userId': userId,
        'avatar_url': avatarUrl,
        'password': password,
      };

  UserModel copyWith({
    String? email,
    String? name,
    String? userId,
    String? avatarUrl,
    String? password,
  }) =>
      UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        password: password ?? this.password,
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
