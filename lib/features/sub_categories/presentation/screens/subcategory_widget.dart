import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/features/sub_categories/presentation/widgets/subcategory_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/domain/entities/products_entity/SubcategoryEntity.dart';

class SubcategoryWidget extends StatelessWidget {
  final List<SubcategoryEntity> subCategoryList;
  const SubcategoryWidget({Key? key, required this.subCategoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1 / 2,
      ),
      itemCount: subCategoryList.length,
      itemBuilder: (context, index) => SubcategoryItem(subcategoryEntity: subCategoryList[index]),
    );
  }
}
