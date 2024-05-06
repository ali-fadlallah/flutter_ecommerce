import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../home/domain/entities/products_entity/SubcategoryEntity.dart';

class SubcategoryItem extends StatelessWidget {
  final SubcategoryEntity subcategoryEntity;
  const SubcategoryItem({Key? key, required this.subcategoryEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: SvgPicture.asset(
            AssetsManager.appBarLogo,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          subcategoryEntity.name ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
