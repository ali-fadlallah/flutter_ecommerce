import 'package:flutter/material.dart';

import '../utils/strings/strings_manager.dart';

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
            StringsManager.viewAll,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
