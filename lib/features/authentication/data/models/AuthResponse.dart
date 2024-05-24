import 'package:flutter_ecommerce_app/features/authentication/data/models/UserModel.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';

/// message : "success"
/// statusMsg : "fail"
/// user : {"name":"Ahmed Abd Al-Muti","email":"ahmedmutti32131@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MmFlNTMwMzIwNTE2MDI3Nzk0NDJlZSIsIm5hbWUiOiJBaG1lZCBBYmQgQWwtTXV0aSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzE0MDg3MjE3LCJleHAiOjE3MjE4NjMyMTd9.k9EPJ_f2P9x0gdgq-G4QWpr3RXboBhfBxv3BHMJWswk"

class AuthResponse {
  AuthResponse({
    this.message,
    this.statusMsg,
    this.user,
    this.token,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  String? statusMsg;
  UserModel? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusMsg'] = statusMsg;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  AuthEntity toAuthEntity() {
    return AuthEntity(
      message: message,
      token: token,
      user: user?.toUserEntity(),
    );
  }
}
