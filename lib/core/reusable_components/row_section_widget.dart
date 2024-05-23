import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RowSectionWidget extends StatelessWidget {
  final String sectionName;
  const RowSectionWidget({Key? key, required this.sectionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        GestureDetector(
          onTap: () {
            print(sectionName);
          },
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
