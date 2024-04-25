import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/domain/entities/category_entity/CategoryEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryEntity categoryEntity;
  HomeCategoryItem({Key? key, required this.categoryEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: categoryEntity.image ?? AssetsManager.imgPlaceHolder,
          fit: BoxFit.fill,
          width: 100.w,
          height: 100.h,
          placeholder: (context, url) => CircleAvatar(
            radius: 50.r,
            backgroundImage: AssetImage(AssetsManager.imgPlaceHolder),
            backgroundColor: Colors.transparent,
          ),
          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 50.r,
            backgroundImage: imageProvider,
            backgroundColor: Colors.transparent,
          ),
        ),
        Text(
          categoryEntity.name ?? '',
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
