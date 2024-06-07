import 'package:flutter/material.dart';

import '../../../data/models/UserModel.dart';
import '../../../domain/entities/AuthEntity.dart';

@immutable
sealed class SignInViewModelState {}

final class SignInViewModelInitial extends SignInViewModelState {}

final class SignInViewModelOnLoading extends SignInViewModelState {}

final class SignInViewModelTogglePassword extends SignInViewModelState {}

final class SignInViewModelOnError extends SignInViewModelState {
  final String? errorMsg;

  SignInViewModelOnError(this.errorMsg);
}

final class SignInViewModelOnSuccess extends SignInViewModelState {
  final AuthEntity? authEntity;

  SignInViewModelOnSuccess(this.authEntity);
}

class GoogleAuthLoading extends SignInViewModelState {}

class AppleAuthLoading extends SignInViewModelState {}

class GoogleAuthSuccess extends SignInViewModelState {
  final UserModel user;

  GoogleAuthSuccess(this.user);
}

class AppleAuthSuccess extends SignInViewModelState {
  final UserModel user;

  AppleAuthSuccess(this.user);
}

class GoogleAuthError extends SignInViewModelState {
  final String message;

  GoogleAuthError(this.message);
}

class AppleAuthError extends SignInViewModelState {
  final String message;

  AppleAuthError(this.message);
}
