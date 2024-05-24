part of 'profile_view_model_cubit.dart';

@immutable
sealed class ProfileViewModelState {}

final class ProfileViewModelInitial extends ProfileViewModelState {}

final class ProfileViewModelOnLoading extends ProfileViewModelState {}

final class ProfileViewModelOnError extends ProfileViewModelState {
  final String? errorMsg;

  ProfileViewModelOnError(this.errorMsg);
}

final class ProfileViewModelOnSuccess extends ProfileViewModelState {
  final AuthEntity authEntity;

  ProfileViewModelOnSuccess(this.authEntity);
}

final class ProfileViewModelEditTextField extends ProfileViewModelState {}
