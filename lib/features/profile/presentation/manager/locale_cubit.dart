import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(const SelectedLocale(
          Locale('en'),
        ));

  static LocaleCubit get(context) => BlocProvider.of(context);

  void toArabic(BuildContext context) {
    emit(const SelectedLocale(Locale('ar')));
    SharedPreferenceHelper.saveData(key: StringsManager.keyLocale, value: 'ar');
    Navigator.pop(context);
  }

  void toEnglish(BuildContext context) {
    emit(const SelectedLocale(Locale('en')));
    SharedPreferenceHelper.saveData(key: StringsManager.keyLocale, value: 'en');
    Navigator.pop(context);
  }

  void retrieveLanguage() {
    final savedLanguage = SharedPreferenceHelper.getData(key: StringsManager.keyLocale);
    savedLanguage == null
        ? SharedPreferenceHelper.saveData(key: StringsManager.keyLocale, value: 'en')
        : emit(SelectedLocale(Locale(
            savedLanguage.toString(),
          )));
  }
}
