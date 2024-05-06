import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(SelectedLocale(const Locale('en')));

  void toArabic(BuildContext context) {
    emit(SelectedLocale(const Locale('ar')));
    SharedPreferenceHelper.saveData(key: StringsManager.keyLocale, value: 'ar');
    Navigator.pop(context);
  }

  void toEnglish(BuildContext context) {
    emit(SelectedLocale(const Locale('en')));
    SharedPreferenceHelper.saveData(key: StringsManager.keyLocale, value: 'en');
    Navigator.pop(context);
  }

  void retrieveLanguage() {
    final savedLanguage = SharedPreferenceHelper.getData(key: StringsManager.keyLocale);
    if (savedLanguage != null) {
      emit(SelectedLocale(Locale(savedLanguage.toString())));
    }
  }
}
