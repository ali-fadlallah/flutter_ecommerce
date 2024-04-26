part of 'auth_screens_cubit.dart';

sealed class AuthScreensState {}

final class AuthScreensInitial extends AuthScreensState {}

final class AuthScreensTogglePassword extends AuthScreensState {}
