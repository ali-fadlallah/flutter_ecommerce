part of 'signin_view_model_cubit.dart';

@immutable
sealed class SignInViewModelState {}

final class SignInViewModelInitial extends SignInViewModelState {}

final class SignInViewModelOnLoading extends SignInViewModelState {}

final class SignInViewModelOnError extends SignInViewModelState {
  final String? errorMsg;

  SignInViewModelOnError(this.errorMsg);
}

final class SignInViewModelOnSuccess extends SignInViewModelState {
  final AuthEntity? authEntity;
  SignInViewModelOnSuccess(this.authEntity);
}
