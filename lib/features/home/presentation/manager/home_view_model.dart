import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeInitiateState());

  int currentIndex = 0;

  setCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    emit(HomeTabChanged());
  }
}

sealed class HomeStates {}

class HomeInitiateState extends HomeStates {}

class HomeTabChanged extends HomeStates {}
