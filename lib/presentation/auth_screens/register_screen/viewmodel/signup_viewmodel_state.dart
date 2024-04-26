part of 'signup_viewmodel_cubit.dart';

sealed class SignupViewModelState {}

final class SignupViewModelInitial extends SignupViewModelState {}

final class SignupViewModelOnLoading extends SignupViewModelState {}

final class SignupViewModelOnError extends SignupViewModelState {
  String? errorMsg;
  SignupViewModelOnError(this.errorMsg);
}

final class SignupViewModelOnSuccess extends SignupViewModelState {
  AuthEntity? authEntity;
  SignupViewModelOnSuccess(this.authEntity);
}
