import 'UserEntity.dart';

class AuthEntity {
  AuthEntity({
    this.message,
    this.user,
    this.token,
  });

  String? message;
  UserEntity? user;
  String? token;
}
