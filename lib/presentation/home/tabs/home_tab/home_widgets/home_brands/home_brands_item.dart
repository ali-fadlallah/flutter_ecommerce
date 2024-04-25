import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/domain/entities/brands_entity/BrandsEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBrandsItem extends StatelessWidget {
  final BrandsEntity brandsEntity;
  const HomeBrandsItem({super.key, required this.brandsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: brandsEntity.image ?? AssetsManager.imgPlaceHolder,
          fit: BoxFit.fill,
          width: 100.w,
          height: 100.h,
          placeholder: (context, url) => CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage(AssetsManager.imgPlaceHolder),
            backgroundColor: Colors.transparent,
          ),
          // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 30.r,
            backgroundImage: imageProvider,
            backgroundColor: Colors.transparent,
          ),
        ),
        Text(
          brandsEntity.name ?? '',
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
