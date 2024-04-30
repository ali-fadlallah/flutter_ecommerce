import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/brands_entity/BrandsEntity.dart';
import 'home_brands_item.dart';

class HomeBrandsWidget extends StatelessWidget {
  final List<BrandsEntity> brandsList;
  const HomeBrandsWidget({Key? key, required this.brandsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 20.w,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: brandsList.length,
            itemBuilder: (context, index) {
              return HomeBrandsItem(
                brandsEntity: brandsList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
