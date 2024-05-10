import 'package:fawry_sdk/model/response.dart';

abstract class FawryState {}

class FawryInitial extends FawryState {}

class FawryInitialSuccess extends FawryState {}

class FawryOnLoading extends FawryState {}

class FawrySuccess extends FawryState {
  final ResponseStatus response;

  FawrySuccess(this.response);
}

class FawryError extends FawryState {
  final String error;

  FawryError(this.error);
}
