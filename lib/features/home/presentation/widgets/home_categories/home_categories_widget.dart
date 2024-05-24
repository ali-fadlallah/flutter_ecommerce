import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../categories/domain/entities/CategoryEntity.dart';
import 'home_category_item.dart';

class HomeCategoriesWidget extends StatelessWidget {
  final List<CategoryEntity> categoryList;

  HomeCategoriesWidget(this.categoryList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 288.h,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return HomeCategoryItem(
                categoryEntity: categoryList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
