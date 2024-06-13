part of 'stripe_cubit.dart';

@immutable
sealed class StripeState {}

final class StripeInitial extends StripeState {}

class StripeOnLoading extends StripeState {}

class StripeOnSuccess extends StripeState {}

class StripeOnError extends StripeState {}

class StripeOnCancel extends StripeState {}
