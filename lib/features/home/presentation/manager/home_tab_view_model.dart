import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabsStates> {
  // AddToCartUseCase addToCartUseCase;

  HomeTabViewModel() : super(HomeTabsInitiateState());

  // static HomeViewModel get(context) => BlocProvider.of(context);
}

sealed class HomeTabsStates {}

class HomeTabsInitiateState extends HomeTabsStates {}

// class HomeTabChanged extends HomeTabsStates {}
