import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/locale_cubit.dart';

class LanguageBottomSheetWidget extends StatefulWidget {
  const LanguageBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _LanguageBottomSheetWidgetState createState() => _LanguageBottomSheetWidgetState();
}

class _LanguageBottomSheetWidgetState extends State<LanguageBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              LocaleCubit.get(context).toEnglish(context);
            },
            child: SharedPreferenceHelper.getData(key: StringsManager.keyLocale) == 'en'
                ? getSelectedLanguage('English')
                : getUnSelectedLanguage('English'),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              LocaleCubit.get(context).toArabic(context);
            },
            child: SharedPreferenceHelper.getData(key: StringsManager.keyLocale) == 'ar'
                ? getSelectedLanguage('العربية ')
                : getUnSelectedLanguage('العربية'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguage(String langName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(langName),
        Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }

  Widget getUnSelectedLanguage(String langName) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        langName,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
