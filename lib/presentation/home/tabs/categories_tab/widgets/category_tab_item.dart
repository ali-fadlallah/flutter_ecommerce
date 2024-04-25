import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/colors/colors_manager.dart';
import 'package:flutter_ecommerce_app/domain/entities/category_entity/CategoryEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ItemClicked = void Function();

class CategoryTabItem extends StatelessWidget {
  final CategoryEntity categoryEntity;
  final ItemClicked onItemClicked;
  final bool isSelected;
  const CategoryTabItem({Key? key, required this.categoryEntity, this.isSelected = false, required this.onItemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemClicked();
      },
      child: Container(
        padding: REdgeInsets.all(5),
        height: 72.h,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Row(
          children: [
            Visibility(
              visible: isSelected,
              child: Container(
                width: 7.w,
                height: 72.h,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Text(
                categoryEntity.name ?? '',
                style: Theme.of(context).textTheme.labelSmall!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
